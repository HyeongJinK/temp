//
//  DeviceClassification.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 19..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

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
