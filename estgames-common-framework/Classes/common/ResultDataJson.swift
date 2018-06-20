//
//  ResultDataJson.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation


public class ResultDataJson {
    public var errorMessage:String?
    var nation: String = ""
    var language: String = ""
    var banner : [Banners]
    var process: [String] = Array<String>()
    var url: UrlData
    
    public init(resultDataJson: NSDictionary) {
        self.errorMessage = resultDataJson["errorMessage"] as? String
        if (self.errorMessage == nil) {
            self.nation = resultDataJson["nation"] as! String
            self.language = resultDataJson["language"] as! String
            self.banner = Array<Banners>()
            
            let eventJson: Array<NSDictionary>? = resultDataJson["banner"] as? Array<NSDictionary>
            let dateFormat = DateFormatter()
            dateFormat.timeZone = TimeZone(identifier: "GMT")
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
            
            let now:Date = Date()
            
            if let ej = eventJson {
                for event in ej {
                    if event["begin"] as? String != nil && now < dateFormat.date(from: event["begin"] as! String)! {
                        continue
                    }
                
                    if event["end"] as? String != nil && now > dateFormat.date(from: event["end"] as! String)! {
                        continue
                    }
                    banner.append(Banners(event))
                }
            }
            
            
            self.process = resultDataJson["process"] as! [String]
            self.url = UrlData(resultDataJson["url"] as! NSDictionary)
        } else {
            self.nation = "en"
            self.language = "en"
            self.banner = Array<Banners>()
            self.process = resultDataJson["process"] as! [String]
            self.url = UrlData(resultDataJson["url"] as! NSDictionary)
        }
    }
}

class Banners {
    var begin:Date?
    var end:Date?
    var banner:BannerData
    
    init(_ jsonData: NSDictionary) {
        self.banner = BannerData(jsonData["banner"] as! NSDictionary)
        
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

class BannerData {
    var name:String
    var content:ContentData
    var writer:String
    var action:ActionData
    
    init(_ jsonData: NSDictionary) {
        self.name = jsonData["name"] as! String
        self.content = ContentData(jsonData["content"] as! NSDictionary)
        self.writer = jsonData["writer"] as! String
        self.action = ActionData(jsonData["action"] as! NSDictionary)
    }
}

class ActionData {
    var type: String = ""
    var url: String
    var button: String
    
    init(_ jsonData: NSDictionary) {
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
    
    init(_ jsonData: NSDictionary) {
        self.type = jsonData["type"] as! String
        self.resource = jsonData["resource"] as! String
    }
}


class ProcessData {
    
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
    
    init(_ jsonData: NSDictionary) {
        self.system_contract = jsonData["system_contract"] as! String
        self.notice = jsonData["notice"] as! String
        self.cscenter = jsonData["cscenter"] as! String
        self.apiParent = jsonData["api_parent"] as! String
        self.characterInfo = jsonData["character_info"] as! String
        self.event = jsonData["event"] as! String
        
        let useContract = jsonData["use_contract"] as! NSDictionary
        
        self.contract_service = useContract["service"] as! String
        self.contract_private = useContract["private"] as! String
    }
}

