//
//  EstCommonService.swift
//  estgames-common-framework_Example
//
//  Created by estgames on 2018. 4. 18..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import Foundation
import estgames_common_framework

class EstCommonService {
    var estgamesCommon: EstgamesCommon
    var processIndex : Int = 0
    var process:[String] = []
    
    init(pView: UIViewController) {
        self.estgamesCommon = EstgamesCommon(pview: pView)
    }
    
    func show() {
        process = estgamesCommon.getProcess()
        check()
    }
    
    func check() {
        if (process.count > processIndex) {
            //call()
        }
    }
    
//    func call() {
//        switch self.process[processIndex] {
//            case "event":
//            break
//            case "system_contract":
//                estgamesCommon.authorityCallBack = check
//                estgamesCommon.authorityShow()
//                break
//            case "use_contract" :
//                //estgamesCommon
//                break
//            case "login" :
//            break
//            default:
//            break
//        }
//        processIndex += 1
//    }
}
