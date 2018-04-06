//
//  AuthorityDataSet.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 6..
//

import Foundation

class AuthorityDataSet {
    var titleLabel: CGRect!
    var webView: CGRect!
    var confirmButton: CGRect!
    
    init(deviceNum: Int) {
        switch(deviceNum) {
        case 320568 :  
            break;
        case 375667 :
            titleLabel = CGRect(x: 0, y: 109, width: 210, height: 47)
            webView = CGRect(x: 23.5, y: 181, width: 328, height: 313.5)
            confirmButton = CGRect(x: 103, y: 519.5, width: 168.5, height: 37.5)
            break;
        case 414736 :
            break;
        case 375812 :
            break;
        case 568320 :
            break;
        case 667375 :
            titleLabel = CGRect(x: 0, y: 36, width: 450, height: 19)
            webView = CGRect(x: 106.5, y: 68, width: 454.5, height: 234.5)
            confirmButton = CGRect(x: 250, y: 320, width: 167.5, height: 37.5)
            break;
        case 736412 :
            break;
        case 812375 :
            break;
        default:
            break;
        }
    }
}
