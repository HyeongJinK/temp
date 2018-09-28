//
//  UserService.swift
//  estgames-common-framework_Example
//
//  Created by estgames on 2018. 4. 16..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import Foundation
import AWSAuthCore
import AWSAuthUI
import AWSFacebookSignIn
import AWSGoogleSignIn
import AWSCore
import FBSDKLoginKit

public class UserService {
    let accountService:AccountService = AccountService()
    let gameService:GameService = GameService()
    var userDialog: UserDialog
    
    var crashSnsSyncIno = (snsEgId: "", egToken:"", profile:"", principal:"", provider: "", email: "")
    var pView: UIViewController
    
    var getGoogleEmail : (() -> String)?
    
    public var failCallBack: (Fail) -> Void = {(message: Fail) -> Void in}
    public var startSuccessCallBack: () -> Void = {() -> Void in }
    public var goToLoginSuccessCallBack: (String?, String, String) -> Void = {(egId: String?, resultType:String, provider:String) -> Void in }
    public var goToLoginCloseCallBack: () -> Void = {() -> Void in}
    public var goToLoginFailCallBack: (Fail) -> Void = {(message: Fail) -> Void in }
    public var goToLoginConfirmCallBack: () -> Void = {() -> Void in }
    public var clearSuccessCallBack: () -> Void = {() -> Void in }
    
    
    public init (pview: UIViewController, googleEmail: @escaping () -> String) {
        self.pView = pview
        userDialog = UserDialog(pview: pView)
        self.getGoogleEmail = googleEmail
    }
    
    func isCognitoSnsLoggedIn() -> Bool {
        if AWSIdentityManager.default().logins().result == nil {
            return false
        } else {
            return true
        }
    }
    
    public func getPrincipal() -> String? {
        return AWSIdentityManager.default().identityId
    }
    
    public func startGame() {
        // 첫 실행 시 키체인 삭제
        let pList = UserDefaults.standard
        if (pList.string(forKey: MpInfo.App.region+"_first") != nil && pList.string(forKey: "estPolicy") != nil) {
            
        } else {
            clearKey();
            pList.set("true", forKey: MpInfo.App.region+"_first")
            pList.synchronize()
        }
        
        
        // 게임클라이언트가 켜지면 첫째 egToken이 존재 하는지 체크
        if MpInfo.Account.isAuthedUser() == false {
            let principal = getPrincipal()
            var device:String = MpInfo.Account.device;
            if (device == "") {
                let uuid = NSUUID().uuidString.lowercased()
                device = uuid+"@ios"
            }
            
            if let pi = principal {
                self.accountService.createToken(
                    principal: pi, device: device, profile: nil, email:"",
                    success: { data in
                        self.startSuccessCallBack()
                },
                    fail: { error in
                        self.failCallBack(Fail.TOKEN_CREATION)
                }
                )
            } else {
                self.failCallBack(Fail.API_ACCESS_DENIED)
            }
        } else {
            let egToken = MpInfo.Account.egToken
            let refreshToken = MpInfo.Account.refreshToken
            let device = MpInfo.Account.device
            
            self.refreshToken(
                egToken: egToken, refreshToken: refreshToken, device: device, profile: nil,
                success: { data in
                    self.startSuccessCallBack()
            },
                fail: { error in
                    //self.accountService.clearKeychain()
                    self.failCallBack(Fail.TOKEN_CREATION)
            })
        }
    }
    
    public func goToLogin(onComplete: @escaping (String?, String, String) -> Void
        , onFail : @escaping (Fail) -> Void
        , onCancel: @escaping () -> Void) {
        goToLoginSuccessCallBack = onComplete
        goToLoginFailCallBack = onFail
        goToLoginCloseCallBack = onCancel
        
        goToLogin()
    }
    
    public func goToLogin(onComplete: @escaping (String?, String, String) -> Void
        , onFail : @escaping (Fail) -> Void
        , onCancel: @escaping () -> Void
        , config : AWSAuthUIConfiguration) {
        goToLoginSuccessCallBack = onComplete
        goToLoginFailCallBack = onFail
        goToLoginCloseCallBack = onCancel
        
        goToLogin(config: config)
    }
    
    public func goToLogin() {
        let config = AWSAuthUIConfiguration()
//        var d:AWSGoogleSignInButton
//        d.textLabel.text = "asdkfj"
        //config.tex
        config.enableUserPoolsUI = false
        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        config.canCancel = true
        config.isBackgroundColorFullScreen = false
        config.logoImage = nil//UIImage(named: "UserIcon")
        
        goToLogin(config: config)
    }
    public func goToLogin(config : AWSAuthUIConfiguration) {
        if MpInfo.Account.isAuthedUser() == false {
            goToLoginFailCallBack(Fail.TOKEN_EMPTY)
            return
        }
        
        if MpInfo.Account.provider != "guest" {
            goToLoginFailCallBack(Fail.ACCOUNT_ALREADY_EXIST)
            return
        }
        
        AWSAuthUIViewController.presentViewController(
            with: pView,
            configuration: config,
            completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error != nil {
                    self.goToLoginFailCallBack(Fail.SIGN_AWS_LOGIN_VIEW)
                } else {
                    self.onSignIn(true, provider)
                }
        })
    }
    
    func onSignIn (_ success: Bool, _ provider: AWSSignInProvider) {
        // 비동기 호출로 인해서 이메일정보를 비동기로 얻고 나서 계정연동 UI를 시작한다. 실패시에 이메일 빈값으로 등록.
        if (success) {
            let identityProviderName:String = provider.identityProviderName
            if identityProviderName == "graph.facebook.com" {
                if((FBSDKAccessToken.current()) != nil)
                {
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil)
                        {
                            var dict = result as! [String : String]
                            FBSDKLoginManager().logOut() // 한번만 사용함.
                            self.snsSyncProcess("facebook", dict["email"] ?? "")
                        } else {
                            self.snsSyncProcess("facebook", "")
                        }
                    })
                } else {
                    self.snsSyncProcess("facebook", "")
                }
            } else if identityProviderName == "accounts.google.com" {
                if getGoogleEmail == nil {
                    self.goToLoginFailCallBack(Fail.GOOGLE_CALLBACK_EMPTY)
                } else {
                    self.snsSyncProcess("google", getGoogleEmail!())
                }
            }
        }
    }
    
    func snsSyncProcess(_ provider:String, _ email:String) {
        if MpInfo.Account.isAuthedUser() == false {
            goToLoginFailCallBack(Fail.TOKEN_EMPTY)
            return
        }
        let profile: String = self.makeProfile(provider, email)
        let egToken = MpInfo.Account.egToken
        let principal = getPrincipal()
        // 이미 cognito의 principal은 업데이트 된 상태
        
        if let pi = principal {
            self.accountService.syncSns(
                egToken: egToken, principal: pi, profile: profile,
                success: {datas in
                    if let status = datas["status"] {
                        let result = String(describing: status)
                        if result == "COMPLETE" {            // 바로 성공
                            MpInfo.Account.principal = pi
                            MpInfo.Account.provider = provider
                            MpInfo.Account.email = email
                            self.goToLoginSuccessCallBack(MpInfo.Account.egId, "LOGIN", provider)
                            //MpInfo.Account.userId = userId
                        } else if result == "FAILURE" {     //guest와 sns 계정 충돌
                            self.visibleSyncView(
                                snsEgId: String(describing: datas["duplicated"]!),
                                egToken: egToken,
                                profile: profile,
                                principal: pi,
                                provider: provider,
                                email: email)
                        } else {    //연동, 충돌 그외의 에러
                            self.goToLoginFailCallBack(Fail.ACCOUNT_SYNC_FAIL)
                        }
                    }
            },
                fail: {error in
                    self.goToLoginFailCallBack(Fail.ACCOUNT_SYNC_FAIL)
            }
            )
        } else {
            self.goToLoginFailCallBack(Fail.API_ACCESS_DENIED)
        }
    }
    
    func visibleSyncView(snsEgId: String, egToken: String, profile: String, principal: String, provider: String, email: String ){   //충돌
        // 로그인된 sns계정 정보를 sync 담당 뷰에 전달.
        crashSnsSyncIno.snsEgId = snsEgId
        crashSnsSyncIno.egToken = egToken
        crashSnsSyncIno.principal = principal
        crashSnsSyncIno.profile = profile
        crashSnsSyncIno.provider = provider
        crashSnsSyncIno.email = email
        
        show()
    }
    
    func show() {
        userDialog.userResultViewController.egId = nil
        userDialog.userResultViewController.resultType = "LOGIN"
        userDialog.userLoadViewController.inputText.text = "";
        userDialog.setUserLinkProviderLabel(provider: self.crashSnsSyncIno.provider)
        userDialog.setUserLinkAction(closeAction: closeAction, confirmAction: linkConfirmAction, cancelAction: linkCancelAction)
        characterInfo(self.crashSnsSyncIno.snsEgId, userDialog.setUserLinkCharacterLabelSNS)
    }
    
    
    
    
    private func linkConfirmAction() {  //sns계정 연동으로
        userLoadShow()
    }
    
    private func linkCancelAction() {   //기존 계정을 사용할 때(guest)
        userGuestLinkShow()
    }
    
    private func loadConfirmAction() -> Bool {
        if userDialog.getInputText()!.lowercased() == "confirm" {
            self.LoginBySnsAccount()
            return true;
        } else {
            goToLoginConfirmCallBack()
            return false;
        }
    }
    
    func LoginBySnsAccount() {
        let principal = getPrincipal()
        
        if let pi = principal {
            var device:String = MpInfo.Account.device;
            if (device == "") {
                let uuid = NSUUID().uuidString.lowercased()
                device = uuid+"@ios"
            }
            
            let email:String = self.crashSnsSyncIno.email
            self.accountService.createToken(
                principal: pi, device: device, profile: self.crashSnsSyncIno.profile, email: email,
                success: { data in
                    MpInfo.Account.provider = self.crashSnsSyncIno.provider
                    MpInfo.Account.email = email
                    
                    self.userDialog.userResultViewController.egId = self.crashSnsSyncIno.snsEgId
                    self.userDialog.userResultViewController.resultType = "SWITCH"
                    self.userDialog.userResultViewController.provider = self.crashSnsSyncIno.provider
            },
                fail: { error in
                    self.goToLoginFailCallBack(Fail.ACCOUNT_NOT_EXIST)
            }
            )
        } else {
            self.goToLoginFailCallBack(Fail.API_ACCESS_DENIED)
        }
    }
    
    private func userLoadShow() {
        userDialog.setUserLoadAction(closeAction: closeAction, confirmCheck: loadConfirmAction, confirmActionCallBack: LoadConfirmCallBack)
        userDialog.showUserLoadDialog()
    }
    
    private func LoadConfirmCallBack() {
        userResultShow()
    }

    private func loginAction() {
        syncForce()
        userResultShow()
    }
    
    private func beforeAction() {
        show()
    }
    
    private func userGuestLinkShow() {
        userDialog.setUserGuestLinkAction(closeAction: closeAction, loginAction: loginAction, beforeAction: beforeAction)
        userDialog.setUserGuestLinkCharacterLabel()
        userDialog.showUserGuestLinkDialog()
    }
    
    private func userResultShow() {
        userDialog.setUserResultAction(closeAction: goToLoginSuccessCallBack, confirmAction: goToLoginSuccessCallBack)
        userDialog.showUserResultDialog()
    }
    
    func syncForce() {
        let profile: String = self.crashSnsSyncIno.profile
        let egToken = self.crashSnsSyncIno.egToken
        let principal = self.crashSnsSyncIno.principal
        let provider = self.crashSnsSyncIno.provider
        let email = self.crashSnsSyncIno.email
        
        // 이미 cognito의 principal은 업데이트 된 상태
        MpInfo.Account.principal = principal
        
        self.accountService.syncSnsByForce(
            egToken: egToken, principal: principal, profile: profile,
            success: {datas in
                if let status = datas["status"] {
                    let result = String(describing: status)
                    if result == "COMPLETE"{
                        MpInfo.Account.principal = principal
                        MpInfo.Account.provider = provider
                        MpInfo.Account.email = email
                        self.userDialog.userResultViewController.resultType = "SYNC"
                        self.userDialog.userResultViewController.provider = provider
                    } else if result == "FAILURE" {
                        // 알 수 없는 오류
                        self.goToLoginFailCallBack(Fail.ACCOUNT_SYNC_FAIL)
                    } else {
                        self.goToLoginFailCallBack(Fail.ACCOUNT_SYNC_FAIL)
                    }
                }
        },
            fail: {
                error in
                self.goToLoginFailCallBack(Fail.ACCOUNT_SYNC_FAIL)
        }
        )
    }
    
    func refreshToken(
        egToken: String, refreshToken: String, device: String, profile: Any?,
        success: @escaping(_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        accountService.refreshToken(egToken: egToken, refreshToken: refreshToken, device: device, profile: profile, success: success, fail: fail)
    }
    
    func closeAction() {
        logout()
        self.goToLoginCloseCallBack()
    }
    
    func logout() {
        if (AWSSignInManager.sharedInstance().isLoggedIn) {
            AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            })
        }
    }
    
    private func characterInfo(_ egId: String, _ f:@escaping (String) -> Void) {
        self.gameService.getCharacterInfo(
            region: MpInfo.App.region, egId: egId, lang : getLanguage(), 
            success: {(data: String) in
                f(data)
                self.userDialog.showUserLinkDialog()
        },
            fail: {(error: Error?) in
                //userDialog.userLinkViewController.
                self.goToLoginFailCallBack(Fail.API_CHARACTER_INFO)
        })
    }
    
    private func characterInfo(_ egId: String) -> String {
        var characterInfo: String = ""
        self.gameService.getCharacterInfo(
            region: MpInfo.App.region, egId: egId, lang : getLanguage(),
            success: {(data: String) in
                characterInfo = data
                self.userDialog.showUserLinkDialog()
        },
            fail: {(error: Error?) in
                self.goToLoginFailCallBack(Fail.API_CHARACTER_INFO)
        })

        return characterInfo
    }
    
    func alert(_ message:String) -> Void{
        let alert = UIAlertController(title: "confirm", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        pView.present(alert, animated: true)
    }
    
    public func clearKey() {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
        })
        self.accountService.clearKeychain()
        let pList = UserDefaults.standard
        pList.set("false", forKey: "estPolicy")
        pList.synchronize()
        clearSuccessCallBack()
    }
    
    private func makeProfile(_ provider: String, _ email: String) -> String {
        var profile: String = ""
        if email != "" {
            profile = "{\"provider\": \"\(provider)\", \"email\": \"\(email)\"}"
        } else {
            profile = "{\"provider\": \"\(provider)\"}"
        }
        return profile
    }
    
    private func getLanguage() -> String {
        if let lang = UserDefaults.standard.string(forKey: "i18n_language") {
            return lang
        }
        
        if let lang = Locale.current.languageCode {
            return lang
        }
        return "ko"
    }
}
