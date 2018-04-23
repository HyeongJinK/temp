//
//  UserService.swift
//  estgames-common-framework_Example
//
//  Created by estgames on 2018. 4. 16..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import Foundation
import estgames_common_framework
import AWSAuthCore
import AWSAuthUI
import AWSFacebookSignIn
import AWSGoogleSignIn
import AWSCore
import FBSDKLoginKit
import GoogleSignIn

public class UserService {
    var userDialog: UserDialog
    var crashSnsSyncIno = (snsEgId: "", egToken:"", profile:"", principal:"", provider: "", email: "")
    let accountService:AccountService = AccountService()
    let gameService:GameService = GameService()
    var pView: UIViewController
    
    public init (pview: UIViewController) {
        self.pView = pview
        userDialog = UserDialog(pview: pView)
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
    
    func refreshToken(
        egToken: String, refreshToken: String, device: String, profile: Any?,
        success: @escaping(_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        accountService.refreshToken(egToken: egToken, refreshToken: refreshToken, device: device, profile: profile, success: success, fail: fail)
    }
    
    private func linkConfirmAction() {  //sns계정 연동으로
        userLoadShow()
    }
    
    private func linkCancelAction() {   //기존 계정을 사용할 때(guest)
        userGuestLinkShow()
    }
    
    func show() {
        userDialog.setUserLinkCharacterLabel(guest: characterInfo(MpInfo.Account.egId), sns: characterInfo(self.crashSnsSyncIno.snsEgId))
        userDialog.setUserLinkAction(closeAction: logout, confirmAction: linkConfirmAction, cancelAction: linkCancelAction)
        userDialog.showUserLinkDialog()
    }
    
    private func loadConfirmAction() -> Bool {
        if userDialog.getInputText()! == "Confirm" {
            self.LoginBySnsAccount()
            return true;
        } else {
            alert("확인문자를 정확히 다시 입력해주세요")
            return false;
        }
        return false
    }
    
    private func LoadConfirmCallBack() {
        userResultShow()
    }
    
    private func userLoadShow() {
        userDialog.setUserLoadAction(closeAction: logout, confirmCheck: loadConfirmAction, confirmActionCallBack: LoadConfirmCallBack)
        userDialog.showUserLoadDialog()
    }
    
    private func loginAction() {
        syncForce()
        userResultShow()
    }
    
    private func beforeAction() {
        show()
    }
    
    private func userGuestLinkShow() {
        userDialog.setUserGuestLinkCharacterLabel(guest: characterInfo(MpInfo.Account.egId), sns: characterInfo(self.crashSnsSyncIno.snsEgId))
        userDialog.setUserGuestLinkAction(closeAction: logout, loginAction: loginAction, beforeAction: beforeAction)
        userDialog.showUserGuestLinkDialog()
    }
    
    private func userResultShow() {
        userDialog.showUserResultDialog()
    }
    
    func LoginBySnsAccount() {
        let principal = getPrincipal()
        
        if let pi = principal {
            let device:String = "device_val@facdebook"
            let email:String = self.crashSnsSyncIno.email
            self.accountService.createToken(
                principal: pi, device: device, profile: self.crashSnsSyncIno.profile, email: email,
                success: { data in
                    MpInfo.Account.provider = self.crashSnsSyncIno.provider
                    MpInfo.Account.email = email
                    // sns 로 keychain이 모두 변경된 상태입니다.
                    //self.visibleView(view: self.viewSnsSuccess)
                    
            },
                fail: { error in
                    self.alert(String(describing: error))
            }
            )
        } else {
            //TODO 계정정보를 못 불러올 때
        }
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
                        
                        // 모달 화면을 닫고 -> guest게이데이터 그대로 이기 때문에 게임이어서 진행.
                        //self.dismiss(animated: true, completion: nil)
                        self.alert("계정연동이 성공되었습니다.")
                    } else if result == "FAILURE" {
                        // 알 수 없는 오류
                        self.alert("FAILURE")
                    } else {
                        self.alert("알 수 없는 에러가 발생했습니다.")
                    }
                }
        },
            fail: {
                error in
                print(String(describing: error))
                self.alert(String(describing: error))
        }
        )
    }
    
    private func characterInfo(_ egId: String) -> String {
        var characterInfo: String = ""
        self.gameService.getCharacterInfo(
            region: MpInfo.App.region, egId: egId,
            success: {(data: Array) in
                for dictItem in data {
                    for (_, v) in dictItem {
                        characterInfo += "\(v) "
                    }
                }
        },
            fail: {(error: Error?) in
                print(error ?? "")
        })
        
        return characterInfo
    }
    
    func logout() {
        if (AWSSignInManager.sharedInstance().isLoggedIn) {
            AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            })
        }
    }
    
    func alert(_ message:String) -> Void{
        let alert = UIAlertController(title: "confirm", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        pView.present(alert, animated: true)
    }
    
    public func startGame() {
        // 게임클라이언트가 켜지면 첫째 egToken이 존재 하는지 체크
        if MpInfo.Account.isAuthedUser() == false {
            let principal = getPrincipal()
            let device:String = "device_val@facdebook"
            
            if let pi = principal {
                self.accountService.createToken(
                    principal: pi, device: device, profile: nil, email:"",
                    success: { data in
                        self.alert("게임을 처음 시작합니다.\n\n 새로운 토큰을 발급 받았습니다. \n\n \(String(describing:data["eg_token"]!))")
                },
                    fail: { error in
                        self.alert(String(describing: error))
                }
                )
            } else {
                //TODO 토큰 미생성시 처리
                self.alert("토큰 생성 오류)")
            }
        } else {
            let egToken = MpInfo.Account.egToken
            let refreshToken = MpInfo.Account.refreshToken
            let device = MpInfo.Account.device
            
            self.refreshToken(
                egToken: egToken, refreshToken: refreshToken, device: device, profile: nil,
                success: { data in
                    self.alert("기존 유저로서 게임을 진행합니다. \n\n(토큰이 갱신되었습니다.) \n\n게임을 이어갑니다.\n\n \(MpInfo.Account.egToken)")
            },
                fail: { error in
                    self.alert(String(describing: error))
            })
        }
    }
    
    public func clearKey() {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
        })
        self.accountService.clearKeychain()
        self.alert("keychain이 삭제되었습니다.")
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
    
    func snsSyncProcess(_ provider:String, _ email:String) {
        if MpInfo.Account.isAuthedUser() == false {
            self.alert("게스트로 로그인이 먼저 필요합니다.")
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
                        if result == "COMPLETE"{
                            MpInfo.Account.principal = pi
                            MpInfo.Account.provider = provider
                            MpInfo.Account.email = email
                            
                            self.alert("계정연동이 성공되었습니다.")
                        } else if result == "FAILURE" {
                            self.visibleSyncView(
                                snsEgId: String(describing: datas["duplicated"]!),
                                egToken: egToken,
                                profile: profile,
                                principal: pi,
                                provider: provider,
                                email: email)
                        } else {
                            self.alert("알 수 없는 에러가 발생했습니다.")
                        }
                    }
            },
                fail: {error in self.alert(String(describing: error))}
            )
        } else {
            //TODO 개인 정보를 못 불러 올 때 처리
        }
        
    }
    
    func visibleSyncView(snsEgId: String, egToken: String, profile: String, principal: String, provider: String, email: String ){
        // 로그인된 sns계정 정보를 sync 담당 뷰에 전달.
        crashSnsSyncIno.snsEgId = snsEgId
        crashSnsSyncIno.egToken = egToken
        crashSnsSyncIno.principal = principal
        crashSnsSyncIno.profile = profile
        crashSnsSyncIno.provider = provider
        crashSnsSyncIno.email = email
        
        show()
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
                if let user = GIDSignIn.sharedInstance().currentUser {
                    self.snsSyncProcess("google", user.profile.email)
                } else {
                    self.snsSyncProcess("google", "")
                }
            }
        }
    }
    
    public func goToLogin() {
        if MpInfo.Account.isAuthedUser() == false {
            self.alert("게스트로 로그인이 먼저 필요합니다. \n\n게임시작을 먼저 해주세요.")
            return
        }
        
        if MpInfo.Account.provider != "guest" {
            self.alert("계정연동은 게스트 상태에서만 가능합니다.")
            return
        }
        
        let config = AWSAuthUIConfiguration()
        
        config.enableUserPoolsUI = false
        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        config.canCancel = true
        config.isBackgroundColorFullScreen = false
        //        let imgUrl = URL(string: entry.banner.resource)
        //        let dtinternet = try? Data(contentsOf: imgUrl!)
        //        self.image = UIImage(data: dtinternet!)
        // config.backgroundColor = UIColor.init(patternImage: UIImage(named: "btn_bottom_close_img", in:Bundle(for: ViewController.self), compatibleWith:nil)!)
        config.logoImage = nil//UIImage(named: "UserIcon")
        //config.logoImage = UIImage(named: "btn_close_img_user", in:Bundle(for: ViewController.self), compatibleWith:nil)
        //UIColor.orange
        
        AWSAuthUIViewController.presentViewController(
            with: pView.navigationController!,
            configuration: config,
            completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error != nil {
                    print("Error occurred: \(String(describing:error))")
                } else {
                    self.onSignIn(true, provider)
                }
        })
    }
}
