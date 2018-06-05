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
    var events : [EventData]
    var process: NSDictionary
    var url: UrlData
    
    public init(resultDataJson: NSDictionary) {
        self.errorMessage = resultDataJson["errorMessage"] as? String
        if (self.errorMessage == nil) {
            self.nation = resultDataJson["nation"] as! String
            self.language = resultDataJson["language"] as! String
            self.events = Array<EventData>()
            
            let eventJson: Array<NSDictionary>? = resultDataJson["event"] as? Array<NSDictionary>
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let now:Date = Date()
            
            if let ej = eventJson {
                for event in ej {
                    if event["begin"] as? String != nil && now < dateFormat.date(from: event["begin"] as! String)! {
                        continue
                    }
                
                    if event["end"] as? String != nil && now > dateFormat.date(from: event["end"] as! String)! {
                        continue
                    }
                    events.append(EventData(event))
                }
            }
            
            
            self.process = resultDataJson["process"] as! NSDictionary
            self.url = UrlData(resultDataJson["url"] as! NSDictionary)
        } else {
            self.nation = "en"
            self.language = "en"
            self.events = Array<EventData>()
            self.process = resultDataJson["process"] as! NSDictionary
            self.url = UrlData(resultDataJson["url"] as! NSDictionary)
        }
    }
}

class EventData {
    var begin:Date?
    var end:Date?
    var banner:BannerData
    
    init(_ jsonData: NSDictionary) {
        self.banner = BannerData(jsonData["banner"] as! NSDictionary)
        
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
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
    var resource:String
    var writer:String
    var action:ActionData
    
    init(_ jsonData: NSDictionary) {
        self.name = jsonData["name"] as! String
        self.resource = jsonData["resource"] as! String
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
    
    init(_ jsonData: NSDictionary) {
        self.system_contract = jsonData["system_contract"] as! String
        self.notice = jsonData["notice"] as! String
        self.cscenter = jsonData["cscenter"] as! String
        self.apiParent = jsonData["api_parent"] as! String
        self.characterInfo = jsonData["character_info"] as! String
        
        let useContract = jsonData["use_contract"] as! NSDictionary
        
        self.contract_service = useContract["service"] as! String
        self.contract_private = useContract["private"] as! String
    }
}

