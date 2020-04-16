//
//  EstgamesCommon.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 17..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit

class EstAppDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //567949206320-ak7je1tvvsgci3d5ppv16hnu7033gh36.apps.googleusercontent.com
        //825002676307-etghc2c1aiqcq5m5duh457gir198mtbg.apps.googleusercontent.com
        GIDSignIn.sharedInstance().clientID = "567949206320-ak7je1tvvsgci3d5ppv16hnu7033gh36.apps.googleusercontent.com"
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return handled && GIDSignIn.sharedInstance().handle(url,
                                                            sourceApplication: sourceApplication,
                                                            annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled && GIDSignIn.sharedInstance().handle(url,
                                                            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
}
