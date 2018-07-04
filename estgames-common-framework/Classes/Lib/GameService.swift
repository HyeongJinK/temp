//
//  GameService.swift
//  MySampleApp
//
//  Created by itempang on 2018. 4. 5..
//

import Foundation
import Alamofire

public class GameService {
    public init() {}
    
    public func getCharacterInfo(
        region: String,egId: String
        , success: @escaping(_ data: String)-> Void
        , fail: @escaping(_ error: Error?)-> Void
        ) {
        
        let url = "https://mp-pub.estgames.co.kr/live/game/"+MpInfo.App.region+"?eg_id="+egId
        request(url)
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.isSuccess) {
                    if let data = response.result.value {
                        let dataJson = data as! NSDictionary
                        let charInfo = dataJson["character"] as! String
                        success(charInfo)
                    }
                } else {
                    fail(response.result.error)
                }
        }
    }
}
