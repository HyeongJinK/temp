//
//  PolicyDataSet.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 30..
//

import Foundation

class PolicyDataSet {
    public var backgroudViewFrame:CGRect
    public var backgroudImageFrame:CGRect
    public var titleLabel1Frame:CGRect
    public var titleLabel2Frame:CGRect
    public var subTitleLabelFrame: CGRect
    public var webView1Frame:CGRect
    public var webView2Frame:CGRect
    public var submitBt1Frame: CGRect
    public var submitBt2Frame: CGRect
    public var closeBtFrame: CGRect
    var titleFontSize:CGFloat = 15
    var subTitleFontSize:CGFloat = 12
    var buttonFontSize:CGFloat = 16

    init(_ width : CGFloat, _ height : CGFloat) {
        switch(width, height) {
        case (320,568) :
            backgroudViewFrame = CGRect(x: (width - 292.5) / 2, y: (height - 524) / 2, width: 292.5, height: 524);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 14)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 14)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 30, y: 11, width: 30, height: 30)
            break
        case (375,667), (414,736), (375,812) :
            backgroudViewFrame = CGRect(x: (width - 293.5) / 2, y: (height - 522.5) / 2, width: 293.5, height: 522.5);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 14)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 14)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 30, y: 11, width: 30, height: 30)
            break
        case (768,1024) :
            titleFontSize = 24
            subTitleFontSize = 18
            buttonFontSize = 29
            backgroudViewFrame = CGRect(x: (width - 525.5) / 2, y: (height - 936.5) / 2, width: 525.5, height: 936.5);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 525.5, height: 936.5)
            titleLabel1Frame = CGRect(x: 0 , y: 69, width: backgroudViewFrame.width, height: 24)
            subTitleLabelFrame = CGRect(x: 0, y: 101, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 47, y: 139, width: 430, height: 242)
            submitBt1Frame = CGRect(x: 47, y: 397, width: 431, height: 66)
            titleLabel2Frame = CGRect(x: 0, y: 513, width: backgroudViewFrame.width, height: 24)
            webView2Frame = CGRect(x: 47, y: 557, width: 430, height: 241)
            submitBt2Frame = CGRect(x: 47, y: 814, width: 431 , height: 66)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 17 - 35, y: 17, width: 35, height: 35)
            break
        case (834,1112):
            titleFontSize = 25
            subTitleFontSize = 19
            buttonFontSize = 29
            backgroudViewFrame = CGRect(x: (width - 550) / 2, y: (height - 980) / 2, width: 550, height: 980);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 550, height: 980)
            titleLabel1Frame = CGRect(x: 0 , y: 70, width: backgroudViewFrame.width, height: 25)
            subTitleLabelFrame = CGRect(x: 0, y: 106, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 49, y: 145, width: 450, height: 254)
            submitBt1Frame = CGRect(x: 49, y: 416, width: 450, height: 69)
            titleLabel2Frame = CGRect(x: 0, y: 539, width: backgroudViewFrame.width, height: 25)
            webView2Frame = CGRect(x: 49, y: 583, width: 450, height: 254)
            submitBt2Frame = CGRect(x: 49, y: 854, width: 450 , height: 69)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 20 - 35, y: 20, width: 35, height: 35)
            break
        case (1024,1366):
            titleFontSize = 30
            subTitleFontSize = 23
            buttonFontSize = 29
            backgroudViewFrame = CGRect(x: (width - 667) / 2, y: (height - 1189) / 2, width: 667, height: 1189);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 667, height: 1189)
            titleLabel1Frame = CGRect(x: 0 , y: 88, width: backgroudViewFrame.width, height: 30)
            subTitleLabelFrame = CGRect(x: 0, y: 130, width: backgroudViewFrame.width, height: 23)
            webView1Frame = CGRect(x: 59, y: 176, width: 547, height: 308)
            submitBt1Frame = CGRect(x: 59, y: 504, width: 547, height: 83)
            titleLabel2Frame = CGRect(x: 0, y: 652, width: backgroudViewFrame.width, height: 30)
            webView2Frame = CGRect(x: 59, y: 707, width: 547, height: 308)
            submitBt2Frame = CGRect(x: 59, y: 1035, width: 547 , height: 83)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 24 - 42, y: 24, width: 42, height: 42)
            break
        case (568,320), (667,375), (736,412), (812,375), (1024,768), (1112,834), (1366,1024) :
            backgroudViewFrame = CGRect(x: (width - 499) / 2, y: (height - 286.5) / 2, width: 499, height: 286.5);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 499, height: 286.5)
            titleLabel1Frame = CGRect(x: 0 , y: 29.5, width: backgroudViewFrame.width, height: 14)
            subTitleLabelFrame = CGRect(x: 0, y: 49, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 9999, y: 9999, width: backgroudViewFrame.width, height: 14)
            webView1Frame = CGRect(x: 26, y: 72.5, width: 219.5, height: 135.5)
            webView2Frame = CGRect(x: 253.5, y: 72.5, width: 219.5, height: 135.5)
            submitBt1Frame = CGRect(x: 26, y: 216.5, width: 220.5, height: 37.5)
            submitBt2Frame = CGRect(x: 253.5, y: 216.5, width: 220.5, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 30, y: 11, width: 30, height: 30)
            break
        default:
            backgroudViewFrame = CGRect(x: 60, y: 106.5, width: 293.5, height: 522.5);
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 14)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 14)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 30, y: 11, width: 30, height: 30)
            break
        }
    }
}
