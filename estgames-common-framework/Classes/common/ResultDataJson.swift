//
//  ResultDataJson.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation


//class ResultDataJson {
//    var nation: String = ""
//    var process: [ProcessData]
//    var events : [EventData]
//    var url: UrlData
//    
//    init(resultDataJson: NSDictionary) {
//        self.nation = resultDataJson["nation"] as! String
//        //self.process
//        self.events = Array<EventData>()
//        self.url = UrlData()
//    }
//}
//
//class ProcessData {
//    
//}
//
//class EventData {
//    var begin:Date?
//    var end:Date?
//    var banner:BannerData
//    
//    init(_ jsonData: NSDictionary) {
//        self.banner = BannerData(jsonData["banner"] as! NSDictionary)
//        
//        let dateFormat: DateFormatter = DateFormatter()
//        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        if jsonData["begin"] as? String != nil {
//            self.begin = dateFormat.date(from: jsonData["begin"] as! String)
//        } else {
//            self.begin = nil
//        }
//        
//        if jsonData["end"] as? String != nil {
//            self.end = dateFormat.date(from: jsonData["end"] as! String)
//        } else {
//            self.end = nil
//        }
//    }
//}
//
//class BannerData {
//    var name:String
//    var resource:String
//    var writer:String
//    var action:ActionData
//    
//    init(_ jsonData: NSDictionary) {
//        self.name = jsonData["name"] as! String
//        self.resource = jsonData["resource"] as! String
//        self.writer = jsonData["writer"] as! String
//        self.action = ActionData(jsonData["action"] as! NSDictionary)
//    }
//}
//
//class ActionData {
//    var type: String = ""
//    var url: String?
//    var button: String?
//    
//    init(_ jsonData: NSDictionary) {
//        self.type = jsonData["type"] as! String
//        if (self.type == "NONE") {
//            self.url = ""
//            self.button = ""
//        } else {
//            self.url = jsonData["url"] as! String
//            self.button = jsonData["button"] as! String
//        }
//    }
//}
//
//class UrlData {
//    var system_contract: String = ""
//    var contract_service: String = ""
//    var contract_private: String = ""
//}

