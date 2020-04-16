//
//  EstAppDelegate.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 24..
//

import Foundation
import AWSAuthCore
import AWSPinpoint
import AWSGoogleSignIn
import AWSFacebookSignIn

public class EstAppDelegate {
    var pinpoint: AWSPinpoint?
    //Used for checking whether Push Notification is enabled in Amazon Pinpoint
    var isInitialized: Bool = false
    
    public init() {
        
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        AWSFacebookSignInProvider.sharedInstance().setPermissions(["public_profile", "email"])
        AWSSignInManager.sharedInstance().register(signInProvider: AWSFacebookSignInProvider.sharedInstance())
        AWSGoogleSignInProvider.sharedInstance().setScopes(["profile", "openid", "email"])
        AWSSignInManager.sharedInstance().register(signInProvider: AWSGoogleSignInProvider.sharedInstance())
        
        
        
        let didFinishLaunching = AWSSignInManager.sharedInstance().interceptApplication(application, didFinishLaunchingWithOptions: launchOptions)
        
        pinpoint = AWSPinpoint(configuration:AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions))
        if (!isInitialized) {
            
            AWSSignInManager.sharedInstance().resumeSession(completionHandler: { (result: Any?, error: Error?) in
                print("Result: \(String(describing: result)) \n Error:\(String(describing: error))")
            })
            isInitialized = true
        }
        return didFinishLaunching
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AWSSignInManager.sharedInstance().interceptApplication(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        isInitialized = true
        
        return true
    }
}
