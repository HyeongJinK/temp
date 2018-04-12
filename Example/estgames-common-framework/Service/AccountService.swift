//
//  AccountService.swift
//  MySampleApp
//
//  Created by itempang on 2018. 4. 4..
//

import Foundation
import SwiftKeychainWrapper

class AccountService {
    init() {}
    
    
    
    private func saveKeychainData(provider: String, egToken:String, principal:String, refreshToken:String, egId:String, device:String, isSyncCrack:Bool=false, email: String) {
        
        MpInfo.Account.provider = provider
        MpInfo.Account.egToken = egToken
        MpInfo.Account.principal = principal
        MpInfo.Account.refreshToken = refreshToken
        MpInfo.Account.egId = egId
        MpInfo.Account.device = device
        MpInfo.Account.isSyncCrack = isSyncCrack
        MpInfo.Account.email = email
    }
    
    func getPrincipal() -> String {
        return AccountApi.getPrincipal()
    }
    
    func getAccountMe(
        egToken:String,
        success: @escaping(_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        
        AccountApi.getAccountMe(
            egToken: egToken,
            success: {(data: Dictionary) in
                success(data)
        },
            fail: {(error: Error?) in
                fail(error)
        })
    }
    
    func createToken(
        principal: String, device: String, profile: Any?,
        success: @escaping (_ data: Dictionary<String, Any>) -> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        
        AccountApi.createToken(
            principal: principal, device: device, profile: nil,
            success: {(tokenData: Dictionary) in
                let egToken:String = tokenData["eg_token"] as! String
                AccountApi.getAccountMe(
                    egToken: egToken,
                    success: {(data: Dictionary) in
                        
                        let refreshToken: String = tokenData["refresh_token"] as! String
                        let egId: String = String(describing: data["eg_id"]!)
                        
                        self.saveKeychainData(
                            provider: "guest", egToken: egToken, principal: principal, refreshToken: refreshToken,
                            egId: egId, device: device, email: "")
                        
                        success(tokenData)
                    },
                    fail: {(error: Error?) in
                        fail(error)
                    }
                )
            },
            fail: {(error: Error?) in
            }
        )
    }
    
    func refreshToken(
        egToken: String, refreshToken: String, device: String, profile: Any?,
        success: @escaping(_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        AccountApi.refreshToken(
            egToken: egToken, refreshToken: refreshToken, device: "device_val@facdebook", profile: nil,
            success: { data in
                MpInfo.Account.egToken = String(describing: data["eg_token"]!)
                success(data)
            },
            fail: { error in
                fail(error)
            }
        )
    }
    
    
    func syncSns(egToken: String, principal: String, profile: String?,
        success: @escaping (_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping (_ error: Error?)-> Void) {
        AccountApi.syncSns(
            egToken: egToken, principal: principal, profile: profile,
            success: {data in success(data)},
            fail: {error in fail(error)}
        )
    }
    
    func syncSnsByForce(
        egToken: String, principal: String, data: String?,
        success: @escaping(_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping (_ error: Error?)-> Void) {
        AccountApi.syncSnsByForce(
            egToken: egToken, principal: principal, data: data,
            success: {data in success(data)},
            fail: {error in fail(error)}
        )
    }
    
    func clearKeychain() {
        KeychainWrapper.standard.removeObject(forKey: "mp.eg_id")
        KeychainWrapper.standard.removeObject(forKey: "mp.eg_token")
        KeychainWrapper.standard.removeObject(forKey: "mp.refresh_token")
        KeychainWrapper.standard.removeObject(forKey: "mp.is_sync_crack")
        KeychainWrapper.standard.removeObject(forKey: "mp.principal")
        KeychainWrapper.standard.removeObject(forKey: "mp.provider")
        KeychainWrapper.standard.removeObject(forKey: "mp.email")
        KeychainWrapper.standard.removeObject(forKey: "mp.device")
    }
}
