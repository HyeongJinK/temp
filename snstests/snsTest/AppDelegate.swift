//
//  AppDelegate.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 10..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var estAppDelegate: EstAppDelegate = EstAppDelegate()
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return estAppDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return estAppDelegate.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return estAppDelegate.application(app, open:url, options:options)
    }
}
