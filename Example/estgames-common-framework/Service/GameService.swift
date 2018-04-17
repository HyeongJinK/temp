//
//  GameService.swift
//  MySampleApp
//
//  Created by itempang on 2018. 4. 5..
//

import Foundation

class GameService {
    
    func getCharacterInfo(
        region: String,
        egId: String,
        success: @escaping(_ data: Array<Dictionary<String, Any>>)-> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        
        if true {
            success([["캐릭명": "치치", "레벨": "Lv4"] ])
        }
        
        //        } else {
        //            fail(response.result.error)
        //        }
        
        //        -> Array<Dictionary<String, String>>? {
        //            return [["캐릭명": "치치", "레벨": "Lv4"]]
    }
}
