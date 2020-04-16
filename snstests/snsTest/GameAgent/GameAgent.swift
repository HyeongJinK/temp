//
//  GameAgent.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 19..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

@objc public class ServiceStatus : NSObject {
    var isServiceOn: Bool = false
    var remainSeconds: Int = 0
    var noticeUrl: String = ""
    
    public func getIsServiceOn() -> Bool {
        return self.isServiceOn
    }
    
    public func getRemainSeconds() -> Int {
        return self.remainSeconds
    }
    
    public func getNoticeUrl() -> String {
        return self.noticeUrl
    }
    
    public init(_ status : Bool, _ time: Int, _ url: String) {
        self.isServiceOn = status;
        self.remainSeconds = time;
        self.noticeUrl = url;
    }
}

@objc public class GameAgent  : NSObject{    
    public func retrieveStatus(onReceived : @escaping (_ result: ServiceStatus) -> Void , onFail : @escaping (_ fail: Fail) -> Void) {
        var status:String = "";
        var time:Int = 0;
        var urlresult:String = "";
        //TODO api 호출
//        let url:String = EstgamesCommon.getOpenUrl()
//        
//        if (url == "") {
//            onFail(Fail.START_API_DATA_INIT)
//        }
//        request(url + "?region="+MpInfo.App.region+"&lang="+getLanguage()!)
//            .validate(contentType: ["application/json"])
//            .validate(statusCode: 200..<404)
//            .responseJSON() {
//                response in
//                if (response.result.isSuccess) {
//                    if let result = response.result.value {
//                        let data = result as! NSDictionary
//                        
//                        let statusTemp:Any? = data["status"]
//                        let timeTemp:Any? = data["time"]
//                        let urlTemp:Any? = data["url"]
//                        
//                        if let tT = timeTemp {
//                            time = tT as! Int
//                        }
//                        
//                        if let uT = urlTemp {
//                            urlresult = uT as! String
//                        }
//                        
//                        if let sT = statusTemp {
//                            status = sT as! String
//                            if (status == "on") {
//                                onReceived(ServiceStatus(true, time, urlresult))
//                            }
//                            else {
//                                onReceived(ServiceStatus(false, time, urlresult))
//                            }
//                        } else {
//                            onFail(Fail.API_BAD_REQUEST)
//                        }
//                    } else {
//                        onFail(Fail.API_UNKNOWN_RESPONSE)
//                    }
//                } else {
//                    onFail(Fail.API_REQUEST_FAIL)
//                }
//        }
        
    }
}