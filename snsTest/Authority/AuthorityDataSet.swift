//
//  AuthorityDataSet.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 19..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

class AuthorityDataSet {
    var titleLabel: CGRect!
    var webView: CGRect!
    var confirmButton: CGRect!
    
    init(_ width: CGFloat, _ height:CGFloat) {
        switch(width, height) {
        case (320,568) :
            titleLabel = CGRect(x: 0, y: 60, width: 320, height: 47)    //width 210 -> 320
            webView = CGRect(x: 15, y: 131.5, width: 290, height: 313.5)
            confirmButton = CGRect(x: 75.5, y: 470, width: 168.5, height: 37.5)
            break;
        case (375,667), (414,736), (375,812), (768,1024), (834,1112), (1024,1366) :
            titleLabel = CGRect(x: 0, y: 109, width: 320, height: 47)
            webView = CGRect(x: (width - 328) / 2, y: 181, width: 328, height: 313.5)
            confirmButton = CGRect(x: (width - 169) / 2, y: 519.5, width: 168.5, height: 37.5)
            break;
        case (568,320), (667,375), (736,412), (812,375), (1024,768), (1112,834), (1366,1024) :
            titleLabel = CGRect(x: 0, y: 36, width: 450, height: 19)
            webView = CGRect(x: (width - 454.5) / 2, y: 68, width: 454.5, height: 234.5)
            confirmButton = CGRect(x: (width - 168), y: 320, width: 167.5, height: 37.5)
            break;
        default:
            titleLabel = CGRect(x: 0, y: 109, width: 320, height: 47)
            webView = CGRect(x: (width - 328) / 2, y: 181, width: 328, height: 313.5)
            confirmButton = CGRect(x: (width - 169) / 2, y: 519.5, width: 168.5, height: 37.5)
            break;
        }
    }
}
