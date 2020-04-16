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
        var type: String = ""
        type = Int(width).description + Int(height).description
        return Int(type)!;
    }
}
