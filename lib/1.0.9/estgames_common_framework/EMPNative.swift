//
//  EMPNative.swift
//  EMPBridge
//
//  Created by MRStudio on 15/05/2018.
//  Copyright © 2018 MRStudio. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import estgames_common_framework


@objc public class EMPNative : NSObject {
    @objc static let shared = EMPNative()
    override private init() {}
    
    var estCommon: EstgamesCommon! = nil
    var estAccount: UserService! = nil
    
    static let remoteNotificationKey = "RemoteNotification"
    var estAppDelegate: EstAppDelegate = EstAppDelegate()
    
    
    // app delegate
    @objc func testfunction() {
        
    }
    
    @objc func application_didFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return estAppDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @objc func application_openURLWithSourceApplication(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any = [:]) -> Bool {
        return estAppDelegate.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    @objc func application_openURLWithOptionKey(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    

    // util func
    func googleEmail() -> String
    {
		print("[EMPNative.swift] googleEmail()")
        if let user = GIDSignIn.sharedInstance().currentUser {
            return user.profile.email
        }
        else {
            return ""
        }
    }

    
    // functions
    @objc func emp_init() {
        print("[EMPNative.swift] emp_init()")
        let viewObj: UIViewController = UnityGetGLViewController()

        estCommon = EstgamesCommon(pview:viewObj)
        estCommon.estCommonFailCallBack = emp_est_fail_callBack //에러가 났을 경우 호출되는 콜백함수입니다.
        estCommon.create()  // 이제 startAPI호출이 생성자가 아닌 create함수에서 호출됩니다.
        estAccount = UserService(pview:viewObj, googleEmail:googleEmail)
        
        if let _: EstgamesCommon = estCommon
        {
            if let _: UserService = estAccount
            {
                
            }
        }
    }
    
    @objc func emp_startGame() {
        print("[EMPNative.swift] emp_startGame()")
        estAccount.startSuccessCallBack = emp_startGame_success_callback
        //estAccount.startFailCallBack = emp_startGame_fail_callback    failCallBack함수로 변경되었습니다. goToLogin 에러도 같이 처리합니다.
        estAccount.failCallBack = emp_fail_callBack
        estAccount.startGame()
    }
    
    @objc func emp_processStart() {
		print("[EMPNative.swift] emp_processStart()")
        estCommon.processShow()
    }
    
    @objc func emp_bannerShow() {
		print("[EMPNative.swift] emp_bannerShow()")
        estCommon.bannerCallBack = emp_bannerShow_callback
        estCommon.bannerShow()
    }
    
    @objc func emp_policyShow() {
		print("[EMPNative.swift] emp_policyShow()")
        estCommon.policyShow()
    }
    
    @objc func emp_authorityShow() {
		print("[EMPNative.swift] emp_authorityShow()")
        estCommon.authorityShow()
    }
    
    @objc func emp_showNotice() {
		print("[EMPNative.swift] emp_showNotice()")
        estCommon.showNotice()
    }
    
    @objc func emp_showCsCenter() {
		print("[EMPNative.swift] emp_showCsCenter()")
        estCommon.showCsCenter()
    }
    
    @objc func emp_goToLogin() {
		print("[EMPNative.swift] emp_goToLogin()")
        estAccount.goToLoginCloseCallBack = emp_goToLogin_close_callback   //계정연동중 중간에 X버튼을 눌렀을 경우
        estAccount.goToLoginSuccessCallBack = emp_goToLogin_success_callback//계정연동 완료 팝업까지 가서 닫기나, X버튼을 눌렀을 경우
        estAccount.goToLogin()
    }
    
    @objc func emp_Logout() {
		print("[EMPNative.swift] emp_Logout()")
        estAccount.clearKey()       //해당 함수를 호출하면 로그아웃됩니다.
    }

    @objc func emp_getNation() -> String? {
        print("[EMPNative.swift] emp_getNation()")
        return estCommon.getNation()
    }
    
    @objc func emp_getLanguage() -> String? {
        print("[EMPNative.swift] emp_getLanguage()")
        return estCommon.getLanguage()
    }
    
    
    // callbacks
    func emp_init_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_init_callback", result)
    }
    
    func emp_startGame_success_callback() -> Void
    {
        UnitySendMessage("NativeBridge", "emp_startGame_success_callback", "result: SUCCESS")
    }
    
    //임의로 만든 에러처리 콜백함수입니다.
    func emp_est_fail_callBack(result: Fail) -> Void
    {
        switch result {
        case .START_API_DATA_INIT:
            print("START_API_DATA_INIT")
            estCommon.create()
            break
        default:
            break
        }
        UnitySendMessage("NativeBridge", "emp_est_fail_callback", "emp_est_fail_callback")
    }
    
    //임의로 만든 에러처리 함수입니다.
    func emp_fail_callBack(result: Fail) -> Void
    {
        var message: String = "ERROR"
        switch result {
        case .ACCOUNT_ALREADY_EXIST:
            message = "ACCOUNT_ALREADY_EXIST"
            break
        case .ACCOUNT_INVALID_PROPERTY:
            message = "ACCOUNT_INVALID_PROPERTY"
            break
        default:
            message = "ERROR"
            break
        }
        UnitySendMessage("NativeBridge", "emp_fail_callback", message)
    }
    
//    func emp_startGame_fail_callback(result: String) -> Void
//    {
//        UnitySendMessage("NativeBridge", "emp_startGame_fail_callback", result)
//    }
    
    func emp_processStart_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_processStart_callback", result)
    }
    
    func emp_bannerShow_callback() -> Void
    {
        print("emp_bannerShow_callback Called!!")
        UnitySendMessage("NativeBridge", "emp_bannerShow_callback", "result: BannerShow")
    }
    
    func emp_policyShow_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_policyShow_callback", result)
    }
    
    func emp_authorityShow_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_authorityShow_callback", result)
    }
    
    func emp_showNotice_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_showNotice_callback", result)
    }
    
    func emp_showCsCenter_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_showCsCenter_callback", result)
    }
    //egId : SNS에 있는 계정을 불러올 경우 변경된 egId값을 리턴합니다. 게스트 계정을 그대로 사용할 경우 nil값을 리턴합니다.
    //resultType: SNS에 있는 계정으로 로그인 = "LOGINBYSNS"   게스트 계정을 그대로 사용 = "LOGINBYFORCE"
    func emp_goToLogin_success_callback(egId: String?, resultType: String) -> Void
    {
        print(egId)
        print(resultType)
        //UnitySendMessage("NativeBridge", "emp_goToLogin_success_callback", egId)
        UnitySendMessage("NativeBridge", "emp_goToLogin_success_callback", resultType)
    }
    
    func emp_goToLogin_close_callback() -> Void
    {
        UnitySendMessage("NativeBridge", "emp_goToLogin_close_callback", "close")
    }
    
//    func emp_goToLogin_fail_callback(result: String) -> Void  //failCallBack에 통합되었습니다.
//    {
//        UnitySendMessage("NativeBridge", "emp_goToLogin_fail_callback", result)
//    }
    
    func emp_Logout_callback(result: String) -> Void
    {
        UnitySendMessage("NativeBridge", "emp_Logout_callback", result)
    }
}
