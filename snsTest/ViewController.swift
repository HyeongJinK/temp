//
//  ViewController.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 10..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit
import GoogleSignIn



// [START viewcontroller_interfaces]
class ViewController: UIViewController, GIDSignInUIDelegate {
    @IBAction func uuidAction(_ sender: Any) {
        let api: Api = Api()
        
        var uid = UUID().uuidString
        let p = api.principal(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, identity: uid)!
        print(p)
//        print("\(uid)@ios")
//        let t = api.token(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, region: MpInfo.App.region, device: "\(uid)@ios", principal: p)
//        print(t)
//        let egToken = t!["eg_token"] as! String
//        print(egToken)
//        let m = api.me(egToken: egToken)
//        print(m)
    }
    
    @IBAction func auth(_ sender: Any) {
        var eg:EgClient = EgClient()
        
        eg.from(pview: self)
        var action:Action = Action<String>()
        action.onDone = {(message: String) -> Void in
            print(message);
        }
        eg.authority(action: action)
    }
    @IBOutlet var signInButton: GIDLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        GIDSignIn.sharedInstance().uiDelegate = self
        let at:Api = Api()
        
//        at.appScript(region: MpInfo.App.region, lang: "ko", completion: {(data: Data?) -> Void in
//            guard let data = data else { return }
//            //.dataUsingEncoding(NSUTF8StringEncoding)
//            //NSJSONSerialization.JSONObjectWithData(data, options:[]) as? [String: AnyObject]
//            var rd:ResultDataJson = ResultDataJson(data)
////            do {
////                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
////                print(json)
////                let banners = json!["banner"] as? [[String: Any]]
////                for banner in banners! {
////                    let b = banner["banner"] as? [String: Any]
////                    //print("test = \(banner["end"])")
////                    //print("test = \(banner["begin"])")
////                    //print("test = \(banner["banner"])")
////                    //print(b!["action"])
////                }
////
////            } catch {
////
////            }
//            print("data = \(rd)")
//            
//        })
        
        //FBSDKLoginManager.
        let gloginButton = GIDLoginButton()
        let loginButton = FBLoginButton()
        print("dsfkjsdf = " + loginButton.currentTitle!)
        
        //중앙으로 배치
        gloginButton.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        
        loginButton.center = view.center
        
        //뷰에 추가
        view.addSubview(loginButton)
        view.addSubview(gloginButton)
        
        
        
        
        
        
        
        //print(eg.authority())
    }
    
//    @IBAction func signInAction(_ sender: Any) {
//        GIDSignIn.sharedInstance().signIn()
//    }
}
