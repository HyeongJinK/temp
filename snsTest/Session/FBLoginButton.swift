//
//  FBLoginButton.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FBLoginButton : FBSDKLoginButton {
    
    init() {
        super.init(frame : CGRect.zero)
        self.readPermissions = ["public_profile","email"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
