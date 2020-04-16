//
//  MpInfo.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

public class MpInfo {
    static var mpDict = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist")!)?.object(forKey: "MP") as! Dictionary<String, String>
    
    public class App {
        public static var appId: String {
            get {
                return MpInfo.mpDict["app_id"]!
            }
        }
        
        public static var region: String {
            get {
                return MpInfo.mpDict["region"]!
            }
            set(newval) {
                MpInfo.mpDict["region"]! = newval
            }
        }
        
        public static var appName: String {
            get {
                return MpInfo.mpDict["app_name"]!
            }
        }
        
        public static var clientId: String {
            get {
                return MpInfo.mpDict["client_id"]!
            }
        }
        
        public static var secret: String {
            get {
                return MpInfo.mpDict["secret"]!
            }
        }
        
        public static var estapi: String {
            get {
                return MpInfo.mpDict["estapi"]!
            }
        }
        
        public static var accountApi: String {
            get {
                return MpInfo.mpDict["account_api"]!
            }
        }
        
        public static var env: String {
            get {
                return MpInfo.mpDict["env"]!
            }
            set(newval) {
                MpInfo.mpDict["env"]! = newval
            }
        }
    }
    
    public class Account {
        
        public static func isAuthedUser() -> Bool {
            let egToken = MpInfo.Account.egToken
            if String(egToken).count > 5 {
                return true
            } else {
                return false
            }
        }
        
        public internal(set) static var egId: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.eg_id") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.eg_id")
            }
        }
        
        public internal(set) static var egToken: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.eg_token") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.eg_token")
            }
        }
        
        public internal(set) static var refreshToken: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.refresh_token") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.refresh_token")
            }
        }
        
        public internal(set) static var principal: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.principal") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.principal")
            }
        }
        
        public internal(set) static var provider: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.provider") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.provider")
            }
        }
        
        public internal(set) static var email: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.email") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.email")
            }
        }
        
        public internal(set) static var device: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.device") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.device")
            }
        }
        
        public internal(set) static var userId: String {
            get {
                return KeychainWrapper.standard.string(forKey: MpInfo.App.region+"_mp.user_id") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: MpInfo.App.region+"_mp.user_id")
            }
        }
    }
}
