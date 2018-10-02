//
//  UserDataSet.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 28..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

class UserDataSet {
    var titleLabel: CGRect?
    var closeButton: CGRect?
    var lineView: CGRect?
    
    var userLinkCloseButton: CGRect?
    var userLinkLineView: CGRect?
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
    
    let buttonSize:CGFloat = 15
    let titleSize:CGFloat = 16
    let contentSize:CGFloat = 14
    
    init (_ width:CGFloat, _ height: CGFloat ) {
        switch(width, height) {
        case (320,568) :
            userLinkBackgroudView = CGRect(x: (width - 290) / 2, y: (height - 254) / 2, width: 290, height: 254)
            userLoadbackgroundView = CGRect(x: (width - 290) / 2, y: (height - 238) / 2, width: 290, height: 238)
            userResultBackgroundView = CGRect(x: (width - 290) / 2, y: (height - 198) / 2, width: 290, height: 198)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 259.5, y: 5, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 290, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 259.5, y: 5, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 290, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 110)
            userLinkBottomLabel = CGRect(x: 22, y: userLinkBackgroudView!.height - 83, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 56, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: userLinkBackgroudView!.height - 47, width: 123, height: 37)
            userLinkCancelButton = CGRect(x: 149, y: userLinkBackgroudView!.height - 47, width: 123, height: 37)
            
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 78)
            userLoadConfirmLabel = CGRect(x: 22, y: 147, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 179, width: 171.5, height: 35)
            userLoadConfirmButton = CGRect(x: 195.5, y: 179, width: 70, height: 35)
            
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 246, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 84, width: 270, height: 10)
            userResultConfirmButton = CGRect(x: 83.5, y: 151, width: 123.5, height: 37.5)
            break;
        case (375,667), (414,736), (375,812), (768,1024), (834,1112), (1024,1366):
            userLinkBackgroudView = CGRect(x: (width - 328) / 2, y: (height - 250) / 2, width: 328, height: 250)
            userLoadbackgroundView = CGRect(x: (width - 328) / 2, y: (height - 240) / 2, width: 328, height: 240)
            userResultBackgroundView = CGRect(x: (width - 328) / 2, y: (height - 187) / 2, width: 328, height: 187)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 297.5, y: 5, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 297.5, y: 5, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 284, height: 110)
            userLinkBottomLabel = CGRect(x: 22, y: userLinkBackgroudView!.height - 83, width: 284, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 56, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 284, height: 78)
            userLoadConfirmLabel = CGRect(x: 22, y: 147, width: 284, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 174, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 174, width: 70, height: 35)
            
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 284, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 84, width: 284, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        case (568,320), (667,375), (736,412), (812,375), (1024,768), (1112,834), (1366,1024) :
            userLinkBackgroudView = CGRect(x: (width - 370) / 2, y: (height - 209.5) / 2, width: 370, height: 209.5)
            userLoadbackgroundView = CGRect(x: (width - 342) / 2, y: (height - 188.5) / 2, width: 342, height: 188.5)
            userResultBackgroundView = CGRect(x: (width - 342) / 2, y: (height - 188.5) / 2, width: 342, height: 188.5)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 339.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 370, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 326, height: 110)
            userLinkBottomLabel = CGRect(x: 22, y: 130, width: 326, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 153.5, width: 370, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18.5, y: 162.5, width: 163, height: 37)
            userLinkCancelButton = CGRect(x: 189.5, y: 162.5, width: 163, height: 37)
            
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 298, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 298, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124.5, width: 210, height: 35)
            userLoadConfirmButton = CGRect(x: 234, y: 124.5, width: 70, height: 35)
            
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 298, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 298, height: 10)
            userResultConfirmButton = CGRect(x: 109, y: 143.5, width: 123.5, height: 37.5)
            break;
        default:
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 298, height: 110)
            userLinkBottomLabel = CGRect(x: 22, y: userLinkBackgroudView!.height - 83, width: 284, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 56, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 298, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 298, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 124, width: 70, height: 35)
            
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 298, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 298, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        }
    }
}
