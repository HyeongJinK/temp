//
//  DeviceClassification.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//
// 화면 해상도에 따른 크기  아이폰6 조절 375 667

/*
 320 * 480, 568
 375 * 667, 812
 414 * 736
 
 
 */
import Foundation

public class DeviceClassification {
    public static func deviceResolution(_ frame:CGRect) -> Int {
        return deviceResolution(frame.width, frame.height)
    }
    public static func deviceResolution(_ width:CGFloat, _ height:CGFloat) -> Int {
        //폰 해상도 구분
        var type = 0
        
        if (UIDevice.current.orientation.rawValue == 0 ) {
            if (width.isEqual(to: 320)) {
                if (height.isEqual(to: 480)) {
                    type = 1
                } else if (height.isEqual(to: 568)) {
                    type = 3
                }
            } else if (width.isEqual(to: 375)) {
                if (height.isEqual(to: 667)) {
                    type = 5
                } else if (height.isEqual(to: 812)) {
                    type = 9
                }
            } else if (width.isEqual(to: 414)) {
                type = 7
            } else if (width.isEqual(to: 480)) {
                type = 2
            } else if (width.isEqual(to: 568)) {
                type = 4
            } else if (width.isEqual(to: 667)) {
                type = 6
            } else if (width.isEqual(to: 736)) {
                type = 8
            } else if (width.isEqual(to: 812)) {
                type = 10
            }
        } else if (UIDevice.current.orientation.isPortrait) {
            if (height.isEqual(to: 480)) {
                type = 1
            } else if (height.isEqual(to: 568)) {
                type = 3
            } else if (height.isEqual(to: 667)) {
                type = 5
            } else if (height.isEqual(to: 812)) {
                type = 9
            } else if (height.isEqual(to: 736)) {
                type = 7
            }
        } else if (UIDevice.current.orientation.isLandscape) {
            if (width.isEqual(to: 480)) {
                type = 2
            } else if (width.isEqual(to: 568)) {
                type = 4
            } else if (width.isEqual(to: 667)) {
                type = 6
            } else if (width.isEqual(to: 812)) {
                type = 10
            } else if (width.isEqual(to: 736)) {
                type = 8
            }
        }
        return type;
    }
}
