//
//  UserDataSet.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 3..
//

import Foundation

class UserDataSet {
    var titleLabel: CGRect?
    var closeButton: CGRect?
    var lineView: CGRect?
    
    var userLinkBackgroudView: CGRect?
    var userLinkMiddleLabel: CGRect?
    var userLinkBottomLabel: CGRect?
    var userLinkLineView2: CGRect?
    var userLinkConfirmButton: CGRect?
    var userLinkCancelButton: CGRect?
    
    var userLoadbackgroundView: CGRect?
    var userLoadMiddleLabel: CGRect?
    var userLoadConfirmLabel: CGRect?
    var userLoadInputButton: CGRect?
    var userLoadConfirmButton: CGRect?
    
    var userResultBackgroundView: CGRect?
    var userResultSubLabel: CGRect?
    var userResultContentLabel: CGRect?
    var userResultConfirmButton: CGRect?
    
    
    init(deviceNum: Int) {
        switch(deviceNum) {
        case 320480 :
            break;
        case 320568 :
            break;
        case 375667 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 60, height: 12)
            closeButton = CGRect(x: 297.5, y: 12, width: 14, height: 14)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 23.5, y: 226, width: 328, height: 214)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 132, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 158, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: 167, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: 167, width: 142, height: 37)
            
            userLoadbackgroundView = CGRect(x: 23.5, y: 262.5, width: 328, height: 187)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 105.5, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 124, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 23.5, y: 262.5, width: 328, height: 187)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        case 414736 :
            break;
        case 375812 :
            break;
        case 480320 :
            break;
        case 568320 :
            break;
        case 667375 :
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
