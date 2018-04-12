//
//  GameService.swift
//  MySampleApp
//
//  Created by itempang on 2018. 4. 5..
//

import Foundation

class GameService {
    
    func getCharacterInfo(region: String, egId: String)
        -> Array<Dictionary<String, String>>? {
            return [["캐릭명": "치치", "레벨": "Lv4"]]
    }
}
