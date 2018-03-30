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
    
    init(deviceNum: Int) {
        if (deviceNum == 5) {
            backgroudViewFrame = CGRect(x: 41.5, y: 71.5, width: 293.5, height: 522.5)
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 13)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 18, y: 11, width: 18, height: 18)
        } else if (deviceNum == 6) {
            backgroudViewFrame = CGRect(x: 84, y: 43.5, width: 499, height: 286.5)
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 499, height: 286.5)
            titleLabel1Frame = CGRect(x: 0 , y: 29.5, width: backgroudViewFrame.width, height: 14)
            subTitleLabelFrame = CGRect(x: 0, y: 49, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 9999, y: 9999, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 26, y: 72.5, width: 219.5, height: 135.5)
            webView2Frame = CGRect(x: 253.5, y: 72.5, width: 219.5, height: 135.5)
            submitBt1Frame = CGRect(x: 26, y: 216.5, width: 220.5, height: 37.5)
            submitBt2Frame = CGRect(x: 253.5, y: 216.5, width: 220.5, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 18, y: 11, width: 18, height: 18)
        } else {
            backgroudViewFrame = CGRect(x: 41.5, y: 71.5, width: 293.5, height: 522.5)
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 13)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 18, y: 11, width: 18, height: 18)
        }
    }
}
