//
//  ApiManager.swift
//  MySampleApp
//
//  Created by itempang on 2018. 3. 27..
//

import Foundation

class AppInfo {
    // 설정파일에서 불러올 수 있도록 하자
    static let appId = MpInfo.App.appId
    static let region = MpInfo.App.region
    static let appName = MpInfo.App.appName
    static let clientId = MpInfo.App.clientId
    static let secret = MpInfo.App.secret
}

//public enum Method: String {
//    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
//}

public class AccountApi {
    
    init(){}
    static let postHeader = [
        "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
    ]
    //            .validate(statusCode: 200..<300)
    
    
    
    private static func makeCreateTokenParameters(approval_type: String, principal: String, device: String, profile: String?) -> Parameters {
        let parameters: Parameters = [
            "client_id": AppInfo.clientId,
            "secret": AppInfo.secret,
            "region": AppInfo.region,
            "device": device,
            "approval_type": approval_type,
            "principal": principal,
            "profile": ""
        ]
        
        return parameters
    }
    
    private static func makeRefreshTokenParameters(approval_type: String, egToken: String, refreshToken: String,  device: String, profile: Any?) -> Parameters {
        let parameters: Parameters = [
            "client_id": AppInfo.clientId,
            "secret": AppInfo.secret,
            "region": AppInfo.region,
            "device": device,
            "approval_type": approval_type,
            "eg_token": egToken,
            "refresh_token": refreshToken
            
            //            "profile": profile!
        ]
        return parameters
    }
    
    static func getAccountMe(egToken:String,
                             success: @escaping(_ data: Dictionary<String, Any>)-> Void,
                             fail: @escaping(_ error: Error?)-> Void) {
        
        let method: HTTPMethod = .get
        let url = "https://api-account-stage.estgames.co.kr/v2/account/me?eg_token=" + egToken
        request(url, method: method, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if response.result.isSuccess {
                    success(response.result.value as! Dictionary)
                } else {
                    fail(response.result.error)
                }
        }
    }
    
    static func createToken(principal: String, device: String, profile: String?,
                            success: @escaping (_ data: Dictionary<String, Any>) -> Void,
                            fail: @escaping(_ error: Error?)-> Void) {
        
        let method: HTTPMethod = .post
        let url = "https://api-account-stage.estgames.co.kr/v2/account/token"
        
        let params: Parameters = self.makeCreateTokenParameters(approval_type: "principal", principal: principal, device: device, profile: profile)
        
        request(url, method: method, parameters:params, encoding:URLEncoding.httpBody, headers: postHeader )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if response.result.isSuccess {
                    success(response.result.value as! Dictionary)
                } else {
                    fail(response.result.error)
                }
                
        }
    }
    
    static func refreshToken(egToken: String, refreshToken: String, device: String, profile: Any?,
                             success: @escaping(_ data: Dictionary<String, Any>)-> Void,
                             fail: @escaping(_ error: Error?)-> Void) {
        
        let method: HTTPMethod = .post
        let url = "https://api-account-stage.estgames.co.kr/v2/account/token"
        let params: Parameters = self.makeRefreshTokenParameters(approval_type: "refresh_token", egToken: egToken, refreshToken: refreshToken, device: device, profile: profile)
        
        request(url, method: method, parameters:params, encoding:URLEncoding.httpBody, headers: postHeader)
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if response.result.isSuccess {
                    success(response.result.value as! Dictionary)
                } else {
                    fail(response.result.error)
                }
        }
    }
    
    static func syncSns(egToken: String, principal: String, profile: String?,
                        success: @escaping (_ data: Dictionary<String, Any>)-> Void,
                        fail: @escaping (_ error: Error?)-> Void) {
        let method: HTTPMethod = .post
        let url = "https://api-account-stage.estgames.co.kr/v2/account/synchronize"
        var params: Parameters = ["eg_token": egToken, "principal": principal]
        
        if let profile = profile {
            params["data"] = profile
        }
        
        request(url, method: method, parameters:params, encoding:URLEncoding.httpBody, headers: postHeader )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if response.result.isSuccess {
                    success(response.result.value as! Dictionary)
                } else {
                    fail(response.result.error)
                }
        }
    }
    
    static func syncSnsByForce(egToken: String, principal: String, data: String?,
                               success: @escaping(_ data: Dictionary<String, Any>)-> Void,
                               fail: @escaping (_ error: Error?)-> Void) {
        
        let method: HTTPMethod = .post
        let url = "https://api-account-stage.estgames.co.kr/v2/account/synchronize"
        var params: Parameters = ["eg_token": egToken, "principal": principal, "force": "True"]
        if (data != nil) {
            params["data"] = data
        }
        
        print("\(egToken), \(principal), \(data!)")
        
        request(url, method: method, parameters:params, encoding:URLEncoding.httpBody, headers: postHeader)
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                if response.result.isSuccess {
                    success(response.result.value as! Dictionary)
                } else {
                    print(response.result.error.debugDescription)
                    fail(response.result.error)
                }
        }
    }
}
