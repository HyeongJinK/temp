//
//  PolicyDataSet.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

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
        case (375,667), (414,736), (375,812), (768,1024), (834,1112), (1024,1366) :
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
        default: backgroudViewFrame = CGRect(x: 60, y: 106.5, width: 293.5, height: 522.5);
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
