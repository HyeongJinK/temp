//
//  File.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 6. 28..
//

import Foundation
import Alamofire

@objc public class GameAgent  : NSObject{
    public func retrieveStatus(onReceived : @escaping (_ result: Bool) -> Void , onFail : @escaping (_ fail: Fail) -> Void) {
        var sss:String = "";
        let url:String = EstgamesCommon.getOpenUrl()
        
        if (url == "") {
            onFail(Fail.START_API_DATA_INIT)
        }
            request(url + "?region="+MpInfo.App.region)
                .validate(contentType: ["application/json"])
                .validate(statusCode: 200..<404)
                .responseJSON() {
                    response in
                    if (response.result.isSuccess) {
                        if let result = response.result.value {
                            let data = result as! NSDictionary
                            let temp:Any? = data["status"]
                            
                            if let status = temp {
                                sss = status as! String
                                if (sss == "on") {
                                    onReceived(true)
                                }
                                else {
                                    onReceived(false)
                                }
                            } else {
                                onFail(Fail.API_OMITTED_PARAMETER)
                            }
                        } else {
                            onFail(Fail.API_BAD_REQUEST)
                            //self.estCommonFailCallBack(Fail.START_API_DATA_FAIL)
                        }
                    } else {
                        onFail(Fail.API_REQUEST_FAIL)
                        //self.estCommonFailCallBack(Fail.START_API_NOT_CALL)
                    }
            }
        
    }
}
