//
//  Settings.swift
//  MySampleApp
//
//  Created by itempang on 2018. 4. 3..
//

import Foundation
import SwiftKeychainWrapper

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
                return KeychainWrapper.standard.string(forKey: "mp.eg_id") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.eg_id")
            }
        }
        
        public internal(set) static var egToken: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.eg_token") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.eg_token")
            }
        }
        
        public internal(set) static var refreshToken: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.refresh_token") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.refresh_token")
            }
        }
        
        public internal(set) static var principal: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.principal") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.principal")
            }
        }
        
        public internal(set) static var provider: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.provider") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.provider")
            }
        }
        
        public internal(set) static var email: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.email") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.email")
            }
        }
        
        public internal(set) static var device: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.device") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.device")
            }
        }
        
        public internal(set) static var userId: String {
            get {
                return KeychainWrapper.standard.string(forKey: "mp.user_id") ?? ""
            }
            set(newval) {
                KeychainWrapper.standard.set(newval, forKey: "mp.user_id")
            }
        }
    }
}



