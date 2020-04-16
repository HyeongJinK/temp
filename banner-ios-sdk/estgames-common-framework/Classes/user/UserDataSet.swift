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
    
    var buttonSize:CGFloat = 15
    var titleSize:CGFloat = 16
    var contentSize:CGFloat = 14
    var textlineSpacing:CGFloat = 9
    init (_ width:CGFloat, _ height: CGFloat ) {
        switch(width, height) {
        case (320,568) :
            userLinkBackgroudView = CGRect(x: (width - 290) / 2, y: (height - 254) / 3, width: 290, height: 254)
            userLoadbackgroundView = CGRect(x: (width - 290) / 2, y: (height - 238) / 3, width: 290, height: 238)
            userResultBackgroundView = CGRect(x: (width - 290) / 2, y: (height - 198) / 3, width: 290, height: 198)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 261.5, y: 11, width: 18, height: 18)
            lineView = CGRect(x: 0, y: 39, width: 290, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 261.5, y: 11, width: 18, height: 18)
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
        case (375,667), (414,736), (375,812):
            userLinkBackgroudView = CGRect(x: (width - 328) / 2, y: (height - 250) / 2, width: 328, height: 250)
            userLoadbackgroundView = CGRect(x: (width - 328) / 2, y: (height - 240) / 2, width: 328, height: 240)
            userResultBackgroundView = CGRect(x: (width - 328) / 2, y: (height - 187) / 2, width: 328, height: 187)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 299.5, y: 11, width: 18, height: 18)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 299.5, y: 11, width: 18, height: 18)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 284, height: 110)
            userLinkBottomLabel = CGRect(x: 22, y: userLinkBackgroudView!.height - 83, width: 284, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 56, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 284, height: 78)
            userLoadConfirmLabel = CGRect(x: 22, y: 147, width: 284, height: 14)
            userLoadInputButton = CGRect(x: 19, y: 174, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 174, width: 70, height: 35)
            
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 284, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 84, width: 284, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        case (768,1024) :
            titleSize = 30
            contentSize = 23
            buttonSize = 23
            textlineSpacing = 20
            userLinkBackgroudView = CGRect(x: (width - 635) / 2, y: (height - 424) / 2, width: 635, height: 424)
            userLoadbackgroundView = CGRect(x: (width - 635) / 2, y: (height - 424) / 2, width: 635, height: 424)
            userResultBackgroundView = CGRect(x: (width - 635) / 2, y: (height - 424) / 2, width: 635, height: 424)
            titleLabel = CGRect(x: 34, y: 22, width: 400, height: 30)
            closeButton = CGRect(x: 585, y: 20, width: 24, height: 24)
            lineView = CGRect(x: 0, y: 65, width: 635, height: 1)
            
            userLinkCloseButton = CGRect(x: 585, y: 24, width: 24, height: 24)
            userLinkLineView = CGRect(x: 0, y: 65, width: 635, height: 1)
            userLinkMiddleLabel = CGRect(x: 34, y: 56, width: 567, height: 200)
            userLinkBottomLabel = CGRect(x: 34, y: userLinkBackgroudView!.height - 175, width: 567, height: 100)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 93, width: 635, height: 1)
            userLinkConfirmButton = CGRect(x: 32, y: userLinkBackgroudView!.height - 77, width: 279, height: 62)
            userLinkCancelButton = CGRect(x: 324, y: userLinkBackgroudView!.height - 77, width: 279, height: 62)
            
            userLoadMiddleLabel = CGRect(x: 34, y: 56, width: 567, height: 200)
            userLoadConfirmLabel = CGRect(x: 34, y: 244, width: 567, height: 23)
            userLoadInputButton = CGRect(x: 31, y: 299, width: 401, height: 64)
            userLoadConfirmButton = CGRect(x: 442, y: 299, width: 127, height: 64)
            
            userResultSubLabel = CGRect(x: 34, y: 96, width: 567, height: 25)
            userResultContentLabel = CGRect(x: 34, y: 116, width: 567, height: 100)
            userResultConfirmButton = CGRect(x: 178, y: 343, width: 279, height: 62)
            break
        case (834,1112) :
            titleSize = 32
            contentSize = 25
            buttonSize = 25
            textlineSpacing = 18
            userLinkBackgroudView = CGRect(x: (width - 692) / 2, y: (height - 462) / 2, width: 692, height: 462)
            userLoadbackgroundView = CGRect(x: (width - 692) / 2, y: (height - 462) / 2, width: 692, height: 462)
            userResultBackgroundView = CGRect(x: (width - 692) / 2, y: (height - 462) / 2, width: 692, height: 462)
            titleLabel = CGRect(x: 37, y: 23, width: 500, height: 30)
            closeButton = CGRect(x: 636, y: 24, width: 26, height: 26)
            lineView = CGRect(x: 0, y: 70, width: 692, height: 1)
            
            userLinkCloseButton = CGRect(x: 636, y: 24, width: 26, height: 26)
            userLinkLineView = CGRect(x: 0, y: 70, width: 692, height: 1)
            userLinkMiddleLabel = CGRect(x: 37, y: 67, width: 618, height: 200)
            userLinkBottomLabel = CGRect(x: 37, y: userLinkBackgroudView!.height - 185, width: 618, height: 100)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 100, width: 692, height: 1)
            userLinkConfirmButton = CGRect(x: 35, y: userLinkBackgroudView!.height - 84, width: 304, height: 68)
            userLinkCancelButton = CGRect(x: 352, y: userLinkBackgroudView!.height - 84, width: 304, height: 68)
            
            userLoadMiddleLabel = CGRect(x: 37, y: 67, width: 567, height: 200)
            userLoadConfirmLabel = CGRect(x: 37, y: 264, width: 567, height: 25)
            userLoadInputButton = CGRect(x: 33, y: 325, width: 437, height: 70)
            userLoadConfirmButton = CGRect(x: 481, y: 325, width: 139, height: 70)
            
            userResultSubLabel = CGRect(x: 34, y: 104, width: 567, height: 25)
            userResultContentLabel = CGRect(x: 34, y: 131, width: 567, height: 100)
            userResultConfirmButton = CGRect(x: 194, y: 374, width: 304, height: 68)
            break
        case (1024,1366) :
            titleSize = 39
            contentSize = 30
            buttonSize = 30
            textlineSpacing = 20
            userLinkBackgroudView = CGRect(x: (width - 823) / 2, y: (height - 551) / 2, width: 823, height: 551)
            userLoadbackgroundView = CGRect(x: (width - 823) / 2, y: (height - 551) / 2, width: 823, height: 551)
            userResultBackgroundView = CGRect(x: (width - 823) / 2, y: (height - 551) / 2, width: 823, height: 551)
            titleLabel = CGRect(x: 45, y: 28, width: 500, height: 30)
            closeButton = CGRect(x: 762, y: 26, width: 31, height: 31)
            lineView = CGRect(x: 0, y: 84, width: 823, height: 2)
            
            userLinkCloseButton = CGRect(x: 762, y: 26, width: 31, height: 31)
            userLinkLineView = CGRect(x: 0, y: 84, width: 823, height: 2)
            userLinkMiddleLabel = CGRect(x: 46, y: 96, width: 731, height: 200)
            userLinkBottomLabel = CGRect(x: 46, y: userLinkBackgroudView!.height - 205, width: 731, height: 100)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 114, width: 823, height: 1)
            userLinkConfirmButton = CGRect(x: 41, y: userLinkBackgroudView!.height - 97, width: 362, height: 80)
            userLinkCancelButton = CGRect(x: 420, y: userLinkBackgroudView!.height - 97, width: 362, height: 80)
            
            userLoadMiddleLabel = CGRect(x: 46, y: 96, width: 567, height: 200)
            userLoadConfirmLabel = CGRect(x: 46, y: 313, width: 567, height: 10)
            userLoadInputButton = CGRect(x: 40, y: 385, width: 520, height: 86)
            userLoadConfirmButton = CGRect(x: 572, y: 385, width: 165, height: 86)
            
            userResultSubLabel = CGRect(x: 46, y: 125, width: 567, height: 25)
            userResultContentLabel = CGRect(x: 46, y: 153, width: 567, height: 100)
            userResultConfirmButton = CGRect(x: 230, y: 447, width: 362, height: 80)
            break
        case (568,320), (667,375), (736,412), (812,375) :
            userLinkBackgroudView = CGRect(x: (width - 370) / 2, y: (height - 209.5) / 2, width: 370, height: 209.5)
            userLoadbackgroundView = CGRect(x: (width - 342) / 2, y: (height - 188.5) / 2, width: 342, height: 188.5)
            userResultBackgroundView = CGRect(x: (width - 342) / 2, y: (height - 188.5) / 2, width: 342, height: 188.5)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 341.5, y: 11, width: 18, height: 18)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 341.5, y: 11, width: 18, height: 18)
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
            userLinkBackgroudView = CGRect(x: (width - 328) / 2, y: (height - 250) / 2, width: 328, height: 250)
            userLoadbackgroundView = CGRect(x: (width - 328) / 2, y: (height - 240) / 2, width: 328, height: 240)
            userResultBackgroundView = CGRect(x: (width - 328) / 2, y: (height - 187) / 2, width: 328, height: 187)
            titleLabel = CGRect(x: 21.5, y: 15, width: 150, height: 12)
            closeButton = CGRect(x: 299.5, y: 11, width: 18, height: 18)
            lineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            
            userLinkCloseButton = CGRect(x: 299.5, y: 11, width: 18, height: 18)
            userLinkLineView = CGRect(x: 0, y: 39, width: 328, height: 0.5)
            userLinkMiddleLabel = CGRect(x: 22, y: 50.5, width: 284, height: 110)
            userLinkBottomLabel = CGRect(x: 22, y: userLinkBackgroudView!.height - 83, width: 284, height: 10)
            userLinkLineView2 = CGRect(x: 0, y: userLinkBackgroudView!.height - 56, width: 328, height: 0.5)
            userLinkConfirmButton = CGRect(x: 18, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            userLinkCancelButton = CGRect(x: 168, y: userLinkBackgroudView!.height - 47, width: 142, height: 37)
            
            userLoadMiddleLabel = CGRect(x: 22, y: 50.5, width: 284, height: 78)
            userLoadConfirmLabel = CGRect(x: 22, y: 147, width: 284, height: 14)
            userLoadInputButton = CGRect(x: 19, y: 174, width: 209.5, height: 35)
            userLoadConfirmButton = CGRect(x: 233.5, y: 174, width: 70, height: 35)
            
            userResultSubLabel = CGRect(x: 22, y: 59.5, width: 284, height: 12)
            userResultContentLabel = CGRect(x: 22, y: 84, width: 284, height: 10)
            userResultConfirmButton = CGRect(x: 102, y: 140, width: 123.5, height: 37.5)
            break;
        }
    }
}
