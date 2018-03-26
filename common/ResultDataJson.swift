//
//  ResultDataJson.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation


class ResultDataJson {
    var nation: String = ""
    var process: [Process]
    var events : Event
}

class Process {
    
}

class Event {
    var begin: String?
    var end: String?
    var banners: [Banner]
}

class Banner {
    var name: String = ""
    var resource : String = ""
    var writer : String?
}
