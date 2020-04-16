//
//  SessionManager.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

class SessionManager {
    //세션생성
    let api: Api = Api()
    
    func create(principal: String?) {
        let uid = UUID().uuidString
        let p = api.principal(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, identity: uid)
        let token = api.token(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, region: MpInfo.App.region, device: "\(uid)@ios", principal: p!)
        let egToken = token!["eg_token"] as! String
        let me = api.me(egToken: egToken)
        let profile = me!["profile"] as! [String:Any]
        
        MpInfo.Account.device = "\(uid)@ios"
        MpInfo.Account.egToken = token!["eg_token"] as! String
        MpInfo.Account.refreshToken = token!["refresh_token"] as! String
        MpInfo.Account.egId = me!["eg_id"] as! String
        MpInfo.Account.principal = me!["principal_of_client"] as! String
        MpInfo.Account.userId = me!["user_id"] as! String
        let _provider:String? = profile["provider"] as? String
        if _provider != nil {
            MpInfo.Account.provider = _provider!
        }
        let _email:String? = profile["email"] as? String
        if _email != nil {
            MpInfo.Account.email = _email!
        }
    }
    
    //세션 재시작
    func resume() {
        let token = api.refresh(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, region: MpInfo.App.region, device: MpInfo.Account.device, refreshToken: MpInfo.Account.refreshToken, egToken: MpInfo.Account.egToken)
        let egToken = token!["eg_token"] as! String
        let me = api.me(egToken: egToken)
        let profile = me!["profile"] as! [String:Any]

        MpInfo.Account.egToken = token!["eg_token"] as! String
        //MpInfo.Account.refreshToken = token!["refresh_token"] as! String
        MpInfo.Account.egId = me!["eg_id"] as! String
        MpInfo.Account.principal = me!["principal_of_client"] as! String
        MpInfo.Account.userId = me!["user_id"] as! String
        let _provider:String? = profile["provider"] as? String
        if _provider != nil {
            MpInfo.Account.provider = _provider!
        }
        let _email:String? = profile["email"] as? String
        if _email != nil {
            MpInfo.Account.email = _email!
        }
    }
    
    //계정 동기화
    func sync(principal:String, data: [String: String], force:Bool = false) {
        let result = api.synchronize(egToken: MpInfo.Account.egToken, principal: principal, data: data, force: force)
        
        guard let _result = result else {return}
        
        let status:String = _result["status"] as! String
        let _data = _result["data"] as! [String:Any]
        
        if (status.uppercased() == "COMPLETE") {
            MpInfo.Account.egId = _result["eg_id"] as! String
            MpInfo.Account.principal = _result["to"] as! String
            MpInfo.Account.email = _data["email"] as! String
            MpInfo.Account.provider = _data["provider"] as! String
        }
    }
    
    //세션만료
    func expire() {
        api.expire(egToken: MpInfo.Account.egToken)
    }
    
    private func clearKeychain() {
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.eg_id")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.eg_token")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.refresh_token")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.principal")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.provider")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.email")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.device")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.user_id")
    }
    
    func signOut() {
        api.expire(egToken: MpInfo.Account.egToken)
        clearKeychain()
    }
}
