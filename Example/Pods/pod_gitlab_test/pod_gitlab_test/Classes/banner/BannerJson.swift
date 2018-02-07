//
//  bannerData.swift
//  banner
//
//  Created by estgames on 2018. 1. 11..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

class EstgamesBanner {
    var region:String = ""
    var lang:String = ""
    var placement:String = ""
    var entries:[Entry]
    var key:String = ""
    
    init() {
        self.entries = Array<Entry>()
    }
    
    init(jsonData: NSDictionary) {
        self.region = jsonData["region"] as! String
        self.lang = jsonData["lang"] as! String
        self.placement = jsonData["placement"] as! String
        self.key = jsonData["key"] as! String
        
        self.entries = Array<Entry>()
        let entriesJson: Array<NSDictionary> = jsonData["entries"] as! Array<NSDictionary>
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let now:Date = Date()
        
        for entry in entriesJson {
            if entry["begin"] as? String != nil && now < dateFormat.date(from: entry["begin"] as! String)! {
                continue
            }
            
            if entry["end"] as? String != nil && now > dateFormat.date(from: entry["end"] as! String)! {
                continue
            }
            entries.append(Entry(entry))
        }
        
    }
    
    init(region:String, lang:String, placement:String, key:String) {
        self.region = region
        self.lang = lang
        self.placement = placement
        self.key = key
        self.entries = Array<Entry>()
    }
}

class Entry: NSObject {
    var begin:Date?
    var end:Date?
    var banner:Banner
    
    init(_ jsonData: NSDictionary) {
        self.banner = Banner(jsonData["banner"] as! NSDictionary)
        
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

class Banner {
    var name:String
    var resource:String
    var writer:String
    var action:Action
    
    init(_ jsonData: NSDictionary) {
        self.name = jsonData["name"] as! String
        self.resource = jsonData["resource"] as! String
        self.writer = jsonData["writer"] as! String
        self.action = Action(jsonData["action"] as! NSDictionary)
    }
}

class Action {
    var type:String
    var url:String
    var button:String
    
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

