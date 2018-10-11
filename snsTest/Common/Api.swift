//
//  ApiTest.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 12..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

public class Api {//https://m-linker.estgames.co.kr/sd_v_1_live
    private let MP_APP_SCRIPT_API_HOST:String = "https://m-linker.estgames.co.kr/sd_v_1_live"
    private let MP_GAME_API_HOST:String = "https://mp-pub.estgames.co.kr"
    private let MP_BRIDGE_API_HOST:String = "https://api-account.estgames.co.kr"
    private let MP_BRIDGE_API_VERSION:String = "v2"
    
    private func dictionaryToQueryString(_ dict: [String : String]) -> String {
        var parts = [String]()
        for (key, value) in dict {
            let part : String = key + "=" + value
            parts.append(part)
        }
        return parts.joined(separator: "&")
      }

    private func apiCall(url: URL?, method: String, param: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let _url = url else {return}
        //print(_url.absoluteString)
        var request = URLRequest(url: _url)
        request.httpMethod = method
        request.httpBody = param.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: callback)
        task.resume()
    }
    
    public func appScript(region: String, lang: String, completion: @escaping (Data?) -> Void) {
        apiCall(url: URL(string: "\(MP_APP_SCRIPT_API_HOST)?region=\(region)&lang=\(lang)")
            , method: "get"
            , param: ""
            , callback: {(data: Data?, response: URLResponse?, error: Error?) in
            guard let _data = data, error == nil else {
                print("error = \(String(describing: error))")
                completion(nil)
                return
            }
            completion(_data)
        })
    }
    public func principal(clientId: String, secret: String, identity: String) -> String? {
        var result:String? = nil
        var check = true
        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/principal")
            , method: "post"
            , param: dictionaryToQueryString(["client_id":clientId, "secret":secret, "identity":identity])
            , callback: { (data: Data?, response: URLResponse?, error: Error?) in
            //error 일경우 종료
            guard let _data = data, error == nil else {
                print("error = \(String(describing: error))")
                check = false
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: _data, options: []) as! [String: Any]
                result = json["principal"] as? String
                check = false
            }
            catch {
                result = nil
                check = false
            }
        })
        
        while (result == nil && check) {}
        
        return result
    }
    
    public func token(clientId: String, secret: String, region: String, device: String, principal: String) ->  [String: Any]? {
        var result: [String: Any]?
        var check = true
        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/token")
            , method: "post"
            , param: dictionaryToQueryString(["client_id":clientId, "secret":secret, "region":region, "device":device, "principal":principal, "approval_type":"principal"])
            , callback: { (data: Data?, response: URLResponse?, error: Error?) in
                //error 일경우 종료
                guard let _data = data, error == nil else {
                    print("error = \(String(describing: error))")
                    check = false
                    return
                }
                do {
                    result = try JSONSerialization.jsonObject(with: _data, options: []) as? [String: Any]
                    check = false
                }
                catch {
                    result = nil
                    check = false
                }
        })
        
        while (result == nil && check) {}
        
        return result
    }
    
    public func me(egToken: String) ->  [String: Any]? {
        var result: [String: Any]?
        var check = true
        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/me?eg_token=\(egToken)")
            , method: "get"
            , param: ""
            , callback: {(data: Data?, response:URLResponse?, error: Error?) in
            guard let _data = data, error == nil else {
                print("error = \(String(describing: error))")
                check = false
                return
            }
            do {
                result = try JSONSerialization.jsonObject(with: _data, options: []) as? [String: Any]
                check = false
            }
            catch {
                result = nil
                check = false
            }
        })
        
        while (result == nil && check) {}
        
        return result
    }
    
    public func refresh(clientId: String, secret: String, region: String, device: String, refreshToken: String, egToken: String) ->  [String: Any]? {
        var result: [String: Any]?
        var check = true
        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/token")
            , method: "post"
            , param: dictionaryToQueryString(["client_id":clientId, "secret":secret, "region":region, "device":device, "approval_type":"refresh_token",  "refresh_token":refreshToken, "eg_token":egToken])
            , callback: { (data: Data?, response: URLResponse?, error: Error?) in
                //error 일경우 종료
                guard let _data = data, error == nil else {
                    print("error = \(String(describing: error))")
                    check = false
                    return
                }
                do {
                    result = try JSONSerialization.jsonObject(with: _data, options: []) as? [String: Any]
                    check = false
                }
                catch {
                    result = nil
                    check = false
                }
        })
        
        while (result == nil && check) {}
        
        return result
    }
    
    
    
//    public func synchronize(egToken: String, principal: String, data: Hashable<String, Any>, force: Bool) {
//        //\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/synchronize
//        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/me")
//            , method: "post"
//            , param: dictionaryToQueryString(["egToken": egToken])
//            , callback: {(data: Data?, response:URLResponse?, error: Error?) in
//
//        })
//    }
    /**
     class Synchronize(egToken: String, principal: String, data: Map<String, Any> = mapOf(), force: Boolean = false): Api(
     "\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/synchronize", Method.POST,
     hashMapOf(
     "eg_token" to egToken,
     "principal" to principal,
     "data" to JSONObject(data).toString(),
     "force" to force)
     )
     */
    
    public func expire(egToken: String) {
        var result: [String: Any]?
        var check = true
        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/signout")
            , method: "post"
            , param: dictionaryToQueryString(["eg_token": egToken])
            , callback: {(data: Data?, response:URLResponse?, error: Error?) in
                guard let _data = data, error == nil else {
                    print("error = \(String(describing: error))")
                    check = false
                    return
                }
                
                do {
                    result = try JSONSerialization.jsonObject(with: _data, options: []) as? [String: Any]
                    check = false
                }
                catch {
                    result = nil
                    check = false
                }
        })
        while (result == nil && check) {}
    }
    
    public func abandon(egToken: String, clientId: String, secret: String, region: String) {
        apiCall(url: URL(string: "\(MP_BRIDGE_API_HOST)/\(MP_BRIDGE_API_VERSION)/account/abandon")
            , method: "post"
            , param: dictionaryToQueryString(["eg_token": egToken, "client_id" : clientId, "secret":secret, "region":region])
            , callback: {(data: Data?, response:URLResponse?, error: Error?) in
                
        })
    }
    
    public func gameUser(region: String, egId: String, lang: String) {
        //\(MP_GAME_API_HOST)/live/game/\(region
        apiCall(url: URL(string: "\(MP_GAME_API_HOST)/live/game/\(region)")
            , method: "get"
            , param: dictionaryToQueryString(["eg_id" : egId, "lang": lang])
            , callback: {(data: Data?, response:URLResponse?, error: Error?) in
                
        })
    }
    
    public func gameServiceStatus(region: String, lang: String) {
        //
        apiCall(url: URL(string: "\(MP_GAME_API_HOST)/live/game-open-status")
            , method: "get"
            , param: dictionaryToQueryString(["region": region, "lang": lang])
            , callback: {(data: Data?, response:URLResponse?, error: Error?) in
                
        })
    }

/**
 class AppScript(region: String, lang: String):
 Api("\(MP_APP_SCRIPT_API_HOST", Method.GET,
 hashMapOf("region" to region, "lang" to lang)
 )
 
 class Principal(clientId: String, secret:String, identity: String):
 Api("\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/principal", Method.POST,
 hashMapOf(
 "client_id" to clientId,
 "secret" to secret,
 "identity" to identity)
 )
 
 class Token(clientId: String, secret: String, region:String, device:String, principal: String):
 Api("\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/token", Method.POST,
 hashMapOf(
 "client_id" to clientId,
 "secret" to secret,
 "region" to region,
 "device" to device,
 "principal" to principal,
 "approval_type" to "principal")
 )
 
 class Refresh(
 clientId: String, secret:String, region:String,
 device:String, refreshToken:String, egToken:String):
 Api("\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/token", Method.POST,
 hashMapOf(
 "client_id" to clientId,
 "secret" to secret,
 "region" to region,
 "device" to device,
 "approval_type" to "refresh_token",
 "refresh_token" to refreshToken,
 "eg_token" to egToken))
 
 class Me(egToken: String) : Api(
 "\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/me", Method.GET,
 hashMapOf("eg_token" to egToken)
 )
 
 
 
 class Expire(egToken: String): Api(
 "\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/signout", Method.POST,
 hashMapOf("eg_token" to egToken)
 )
 
 class Abandon(egToken: String, clientId: String, secret: String, region: String): Api(
 "\(MP_BRIDGE_API_HOST/\(MP_BRIDGE_API_VERSION/account/abandon", Method.POST,
 hashMapOf(
 "eg_token" to egToken,
 "client_id" to clientId,
 "secret" to secret,
 "region" to region
 )
 )
 
 class GameUser(region: String, egId: String, lang: String): Api(
 "\(MP_GAME_API_HOST/live/game/\(region", Method.GET,
 hashMapOf("eg_id" to egId, "lang" to lang)
 )
 
 class GameServiceStatus(region: String, lang: String): Api(
 "\(MP_GAME_API_HOST/live/game-open-status", Method.GET,
 hashMapOf("region" to region, "lang" to lang)
 )
 */
