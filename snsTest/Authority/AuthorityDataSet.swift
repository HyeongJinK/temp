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
    var titleFontSize:CGFloat = 19
    var contentFontSize:CGFloat = 20
    var buttonFontSize:CGFloat = 16
    
    init(_ width: CGFloat, _ height:CGFloat) {
        switch(width, height) {
        case (320,568) :
            titleLabel = CGRect(x: 0, y: 60, width: 320, height: 47)    //width 210 -> 320
            webView = CGRect(x: 15, y: 131.5, width: 290, height: 313.5)
            confirmButton = CGRect(x: 75.5, y: 470, width: 168.5, height: 37.5)
            break;
        case (375,667), (414,736), (375,812) :
            titleLabel = CGRect(x: 0, y: 109, width: 320, height: 47)
            webView = CGRect(x: (width - 328) / 2, y: 181, width: 328, height: 313.5)
            confirmButton = CGRect(x: (width - 169) / 2, y: 519.5, width: 168.5, height: 37.5)
            break;
        case (568,320), (667,375), (736,412), (812,375) :
            titleLabel = CGRect(x: 0, y: 36, width: 450, height: 19)
            webView = CGRect(x: (width - 454.5) / 2, y: 68, width: 454.5, height: 234.5)
            confirmButton = CGRect(x: (width - 168) / 2, y: 320, width: 167.5, height: 37.5)
            break;
        case (768,1024) :
            titleFontSize = 35
            buttonFontSize = 27
            titleLabel = CGRect(x: 0, y: 144, width: 480, height: 90)
            webView = CGRect(x: (width - 606) / 2, y: 246.5, width: 606, height: 542)
            confirmButton = CGRect(x: (width - 282) / 2, y: 826.5, width: 282, height: 62)
            break;
        case (1024,768) :
            titleFontSize = 27
            buttonFontSize = 25
            titleLabel = CGRect(x: 0, y: 111, width: 760, height: 40)
            webView = CGRect(x: (width - 766) / 2, y: 165, width: 766, height: 395)
            confirmButton = CGRect(x: (width - 280) / 2, y: 596, width: 280, height: 62)
            break;
        case (834,1112) :
            titleFontSize = 40
            buttonFontSize = 29
            titleLabel = CGRect(x: 0, y: 170, width: 500, height: 100)
            webView = CGRect(x: (width - 606) / 2, y: 299, width: 606, height: 542)
            confirmButton = CGRect(x: (width - 312) / 2, y: 876, width: 312, height: 68)
            break
        case (1112,834) :
            titleFontSize = 27
            buttonFontSize = 25
            titleLabel = CGRect(x: 0, y: 144, width: 760, height: 40)
            webView = CGRect(x: (width - 766) / 2, y: 198, width: 766, height: 395)
            confirmButton = CGRect(x: (width - 280) / 2, y: 629, width: 280, height: 62)
            break
        case (1024,1366) :
            titleFontSize = 48
            buttonFontSize = 29
            titleLabel = CGRect(x: 0, y: 220, width: 600, height: 130)
            webView = CGRect(x: (width - 729) / 2, y: 373, width: 729, height: 651)
            confirmButton = CGRect(x: (width - 375) / 2, y: 1072, width: 375, height: 81)
            break;
        case (1366,1024) :
            titleFontSize = 35
            buttonFontSize = 25
            titleLabel = CGRect(x: 0, y: 159, width: 980, height: 50)
            webView = CGRect(x: (width - 989) / 2, y: 230, width: 989, height: 510)
            confirmButton = CGRect(x: (width - 360) / 2, y: 786, width: 360, height: 80)
            break;
        default:
            titleLabel = CGRect(x: 0, y: 109, width: 320, height: 47)
            webView = CGRect(x: (width - 328) / 2, y: 181, width: 328, height: 313.5)
            confirmButton = CGRect(x: (width - 169) / 2, y: 519.5, width: 168.5, height: 37.5)
            break;
        }
    }
}
