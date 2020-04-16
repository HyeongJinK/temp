///
//  GIDLoginButton.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation
import GoogleSignIn

//GIDSignInUIDelegate
class GIDLoginButton: GIDSignInButton, GIDSignInDelegate {
    var manager:SessionManager = SessionManager()
    init() {
        super.init(frame: CGRect.zero)
        GIDSignIn.sharedInstance().delegate = self
        //GIDSignIn.sharedInstance().uiDelegate = self
        self.removeTarget(self, action: #selector(signInAction(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(signInAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
        } else {
            var data:[String:String] = [String:String]()
            data["email"] = user.profile.email
            data["provider"] = "google"
            
            manager.sync(principal: "google:\(user.userID)", data: data)
        }
    }
    @objc func signInAction(_ sender:UIButton) -> String{
        if (MpInfo.Account.egToken != "") {
            GIDSignIn.sharedInstance()?.signIn()
            return "success"
        } else {
            print("not login")
            return "not login"
        }
    }
}

    
//    @objc func signInAction(_ sender:UIButton) {
//        GIDSignIn.sharedInstance().signIn()
//    }

