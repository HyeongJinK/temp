//
//  EstTest.swift
//  objc_ex
//
//  Created by estgames on 2018. 5. 9..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation
import estgames_common_framework

@objc class EstTest : NSObject {
    var est: EstgamesCommon
    @objc init(view: UIViewController) {
        est = EstgamesCommon(pview: view)
    }
    @objc func banerShow () {
        est.policyShow()
    }
}
