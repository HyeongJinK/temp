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
    
    
    init(deviceNum: Int) {
        switch(deviceNum) {
//        case 320480 :
//            break;
        case 320568 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 259.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 290, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 15, y: 172, width: 290, height: 224)
            userLinkCloseButton = CGRect(x: 259.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 290, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 132, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 168, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: 177, width: 123, height: 37)
            userLinkCancelButton = CGRect(x: 149, y: 177, width: 123, height: 37)
            
            userLoadbackgroundView = CGRect(x: 15, y: 185, width: 290, height: 198)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 107, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 139, width: 171.5, height: 35)
            userLoadConfirmButton = CGRect(x: 195.5, y: 139, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 15, y: 185, width: 290, height: 198)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 83.5, y: 151, width: 123.5, height: 37.5)
            break;
        case 375667 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 23.5, y: 226, width: 328, height: 214)
            userLinkCloseButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 132, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 158, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: 167, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: 167, width: 142, height: 37)
            
            userLoadbackgroundView = CGRect(x: 23.5, y: 262.5, width: 328, height: 187)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 124, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 23.5, y: 262.5, width: 328, height: 187)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        case 414736 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 43, y: 261, width: 328, height: 214)
            userLinkCloseButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 132, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 158, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: 167, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: 167, width: 142, height: 37)
            
            userLoadbackgroundView = CGRect(x: 43, y: 274.5, width: 328, height: 187)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 124, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 43, y: 274.5, width: 328, height: 187)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        case 375812 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 23.5, y: 299, width: 328, height: 214)
            userLinkCloseButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 132, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 158, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: 167, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: 167, width: 142, height: 37)
            
            userLoadbackgroundView = CGRect(x: 23.5, y: 299, width: 328, height: 187)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 124, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 23.5, y: 299, width: 328, height: 187)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
//        case 480320 :
//            break;
        case 568320 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 99, y: 55                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              , width: 370, height: 209.5)
            userLinkCloseButton = CGRect(x: 339.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 370, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 130, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 153.5, width: 370, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18.5, y: 162.5, width: 163, height: 37)
            userLinkCancelButton = CGRect(x: 189.5, y: 162.5, width: 163, height: 37)
            
            userLoadbackgroundView = CGRect(x: 160, y: 96, width: 342, height: 188.5)
            userLoadMiddleLabel = CGRect(x: 22, y:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124.5, width: 210, height: 35)
            userLoadConfirmButton = CGRect(x: 234, y: 124.5, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 169, y: 96, width: 342, height: 188.5)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 109, y: 143.5, width: 123.5, height: 37.5)
            break;
        case 667375 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 159, y: 78, width: 370, height: 209.5)
            userLinkCloseButton = CGRect(x: 339.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 370, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 130, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 153.5, width: 370, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18.5, y: 162.5, width: 163, height: 37)
            userLinkCancelButton = CGRect(x: 189.5, y: 162.5, width: 163, height: 37)
            
            userLoadbackgroundView = CGRect(x: 169, y: 96, width: 342, height: 188.5)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124.5, width: 210, height: 35)
            userLoadConfirmButton = CGRect(x: 234, y: 124.5, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 169, y: 96, width: 342, height: 188.5)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 109, y: 143.5, width: 123.5, height: 37.5)
            break;
        case 736412 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 183, y: 101, width: 370, height: 209.5)
            userLinkCloseButton = CGRect(x: 339.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 370, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 130, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 153.5, width: 370, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18.5, y: 162.5, width: 163, height: 37)
            userLinkCancelButton = CGRect(x: 189.5, y: 162.5, width: 163, height: 37)
            
            userLoadbackgroundView = CGRect(x: 197, y: 111.5, width: 342, height: 188.5)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124.5, width: 210, height: 35)
            userLoadConfirmButton = CGRect(x: 234, y: 124.5, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 197, y: 111.5, width: 342, height: 188.5)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 109, y: 143.5, width: 123.5, height: 37.5)
            break;
        case 812375 :
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 235, y: 78, width: 370, height: 209.5)
            userLinkCloseButton = CGRect(x: 339.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 370, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 130, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 153.5, width: 370, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18.5, y: 162.5, width: 163, height: 37)
            userLinkCancelButton = CGRect(x: 189.5, y: 162.5, width: 163, height: 37)
            
            userLoadbackgroundView = CGRect(x: 244, y: 96, width: 342, height: 188.5)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124.5, width: 210, height: 35)
            userLoadConfirmButton = CGRect(x: 234, y: 124.5, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 244, y: 96, width: 342, height: 188.5)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 109, y: 143.5, width: 123.5, height: 37.5)
            break;
        default:
            titleLabel = CGRect(x: 21.5, y: 15, width: 100, height: 12)
            closeButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkBackgroudView = CGRect(x: 23.5, y: 226, width: 328, height: 214)
            userLinkCloseButton = CGRect(x: 297.5, y: 0, width: 30, height: 30)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 66)
            userLinkBottomLabel = CGRect(x: 22, y: 132, width: 270, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: 158, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: 167, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: 167, width: 142, height: 37)
            
            userLoadbackgroundView = CGRect(x: 23.5, y: 262.5, width: 328, height: 187)
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 270, height: 38)
            userLoadConfirmLabel = CGRect(x: 22, y: 97, width: 270, height: 10)
            userLoadInputButton = CGRect(x: 19, y: 124, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 124, width: 70, height: 35)
            
            userResultBackgroundView = CGRect(x: 23.5, y: 262.5, width: 328, height: 187)
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 200, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 79, width: 200, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        }
    }
}
