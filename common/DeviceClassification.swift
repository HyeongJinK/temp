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
 switch(deviceNum) {
 case 320480 :
 break;
 case 320568 :
 break;
 case 375667 :
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
                    type = 320480
                } else if (height.isEqual(to: 568)) {
                    type = 320568
                }
            } else if (width.isEqual(to: 375)) {
                if (height.isEqual(to: 667)) {
                    type = 375667
                } else if (height.isEqual(to: 812)) {
                    type = 375667
                }
            } else if (width.isEqual(to: 414)) {
                type = 414736
            } else if (width.isEqual(to: 480)) {
                type = 480320
            } else if (width.isEqual(to: 568)) {
                type = 568320
            } else if (width.isEqual(to: 667)) {
                type = 667375
            } else if (width.isEqual(to: 736)) {
                type = 736412
            } else if (width.isEqual(to: 812)) {
                type = 812375
            }
        } else if (UIDevice.current.orientation.isPortrait) {
            if (height.isEqual(to: 480)) {
                type = 320480
            } else if (height.isEqual(to: 568)) {
                type = 320568
            } else if (height.isEqual(to: 667)) {
                type = 375667
            } else if (height.isEqual(to: 812)) {
                type = 375812
            } else if (height.isEqual(to: 736)) {
                type = 414736
            }
        } else if (UIDevice.current.orientation.isLandscape) {
            if (width.isEqual(to: 480)) {
                type = 480320
            } else if (width.isEqual(to: 568)) {
                type = 568320
            } else if (width.isEqual(to: 667)) {
                type = 667375
            } else if (width.isEqual(to: 812)) {
                type = 812375
            } else if (width.isEqual(to: 736)) {
                type = 736412
            }
        }
        return type;
    }
}
