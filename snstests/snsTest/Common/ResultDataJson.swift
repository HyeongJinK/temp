//
//  json.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 17..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

public class ResultDataJson {
    var code:String?
    var message:String?
    var nation: String = ""
    var language: String = ""
    var banners : [Banners] = Array<Banners>()
    var process: [String]?
    var url: UrlData?
    
    public init(_ data: Data?) {
        guard let data = data else {return }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            code = json["code"] as? String
            
            guard code != nil else {
                self.nation = json["nation"] as! String
                self.language = json["language"] as! String
                self.process = json["process"] as? [String]
                self.url = UrlData(json["url"] as! [String:Any])
                self.banners = Array<Banners>()
                let bannerArray = json["banner"] as? [[String: Any]]
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
                let now:Date = Date()
                
                guard let _bannerArray = bannerArray else {return}
                
                for banner in _bannerArray {
                    if banner["begin"] as? String != nil && now < dateFormat.date(from: banner["begin"] as! String)! {
                        continue
                    }
                    
                    if banner["end"] as? String != nil && now > dateFormat.date(from: banner["end"] as! String)! {
                        continue
                    }
                    banners.append(Banners(banner))
                }
                return
            }
            self.message = json["message"] as? String
        } catch {
        }
    }
}

class Banners {
    var begin:Date?
    var end:Date?
    var banner:Banner
    
    init(_ jsonData: [String: Any]) {
        self.banner = Banner(jsonData["banner"] as! [String: Any])
        
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.timeZone = TimeZone(identifier: "GMT")
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        
        if jsonData["begin"] as? String != nil {
            self.begin = dateFormat.date(from: jsonData["begin"] as! String)
        } else {
            self.begin = nil
        }
        
        if jsonData["end"] as? String != nil {
            self.end = dateFormat.date(from: jsonData["end"] as! String)
        } else {
            self.end = nil
        }
    }
}

class Banner {
    var name:String
    var content:ContentData
    var writer:String
    var action:ActionData
    
    init(_ jsonData: [String: Any]) {
        self.name = jsonData["name"] as! String
        self.writer = jsonData["writer"] as! String
        self.content = ContentData(jsonData["content"] as! [String: Any])
        self.action = ActionData(jsonData["action"] as! [String: Any])
    }
}

class ActionData {
    var type: String = ""
    var url: String
    var button: String
    
    init(_ jsonData: [String: Any]) {
        self.type = jsonData["type"] as! String
        if (self.type == "NONE") {
            self.url = ""
            self.button = ""
        } else {
            self.url = jsonData["url"] as! String
            self.button = jsonData["button"] as! String
        }
    }
}

class ContentData {
    var resource : String = ""
    var type : String = ""
    
    init(_ jsonData: [String: Any]) {
        self.type = jsonData["type"] as! String
        self.resource = jsonData["resource"] as! String
    }
}


class UrlData {
    var system_contract: String = ""
    var contract_service: String = ""
    var contract_private: String = ""
    var notice: String = ""
    var cscenter:String = ""
    var apiParent:String = ""
    var characterInfo:String = ""
    var event:String = ""
    var game_open:String = ""

    init(_ jsonData: [String: Any]) {
        self.system_contract = jsonData["system_contract"] as! String
        self.notice = jsonData["notice"] as! String
        self.cscenter = jsonData["cscenter"] as! String
        self.apiParent = jsonData["api_parent"] as! String
        self.characterInfo = jsonData["character_info"] as! String
        self.event = jsonData["event"] as! String
        self.game_open = jsonData["game_open_status"] as! String

        let useContract = jsonData["use_contract"] as! [String: Any]

        self.contract_service = useContract["service"] as! String
        self.contract_private = useContract["private"] as! String
    }
}

