//
//  ViewController.swift
//  estgames-common-framework
//
//  Created by wkzkfmxk23@gmail.com on 02/07/2018.
//  Copyright (c) 2018 wkzkfmxk23@gmail.com. All rights reserved.
//

import UIKit
import estgames_common_framework

import AWSAuthCore
import AWSAuthUI
import AWSFacebookSignIn
import AWSGoogleSignIn
import AWSCore

class ViewController: UIViewController {
    var estgamesCommon:EstgamesCommon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estgamesCommon = EstgamesCommon(pview: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func bannerTest(_ sender: Any) {
        estgamesCommon.bannerShow()
    }
    
    @IBAction func authorityTest(_ sender: Any) {
        estgamesCommon.authorityShow()
    }
    
    @IBAction func policyTest(_ sender: Any) {
        estgamesCommon.policyShow()
    }
    
    @IBAction func userLinkTest(_ sender: Any) {
        estgamesCommon.showUserLinkDialog()
    }
    
    @IBAction func UserLoadTest(_ sender: Any) {
        estgamesCommon.showUserLoadDialog()
    }
    
    @IBAction func UserResultTest(_ sender: Any) {
        estgamesCommon.showUserResultDialog()
    }

    @IBAction func testttt(_ sender: Any) {
        print(estgamesCommon.contractService())
        print(estgamesCommon.contractPrivate())
    }
    
    /**
     계정연동 부분
     ***/
    let accountService = AccountService()
    
    
    @IBAction func crateToken(_ sender: Any) {
        startGame()
    }
    
    @IBAction func clearToken(_ sender: Any) {
        clearKey()
    }
    
    @IBAction func snsConnect(_ sender: Any) {
        goToLogin()
    }
    
    func alert(_ message:String) -> Void{
        let alert = UIAlertController(title: "confirm", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func startGame() {
        // 게임클라이언트가 켜지면 첫째 egToken이 존재 하는지 체크
        if MpInfo.Account.isAuthedUser() == false {
            
            let principal = self.accountService.getPrincipal()
            let device:String = "device_val@facdebook"
            self.accountService.createToken(
                principal: principal, device: device, profile: nil,
                success: { data in
                    self.alert("게임을 처음 시작합니다.\n\n 새로운 토큰을 발급 받았습니다. \n\n \(String(describing:data["eg_token"]!))")
            },
                fail: { error in
                    self.alert(String(describing: error))
            }
            )
        } else {
            let egToken = MpInfo.Account.egToken
            let refreshToken = MpInfo.Account.refreshToken
            let device = MpInfo.Account.device
            
            self.accountService.refreshToken(
                egToken: egToken, refreshToken: refreshToken, device: device, profile: nil,
                success: { data in
                    self.alert("기존 유저로서 게임을 진행합니다. \n\n(토큰이 갱신되었습니다.) \n\n게임을 이어갑니다.\n\n \(MpInfo.Account.egToken)")
            },
                fail: { error in
                    self.alert(String(describing: error))
            })
        }
    }
    
    func clearKey() {
        self.accountService.clearKeychain()
        
        self.alert("keychain이 삭제되었습니다.")
    }
    
    func getProfile(identityProviderName: String) -> (provider: String, email: String)  {
        var provider:String = ""
        let email:String = ""
        if identityProviderName == "graph.facebook.com" {
            provider = "facebook"
        } else if identityProviderName == "google" {
            provider = "google"
        } else {
            provider = "google"
        }
        
        return (provider, email)
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
        let principal = AccountService().getPrincipal()
        // 이미 cognito의 principal은 업데이트 된 상태
        MpInfo.Account.principal = principal
        
        self.accountService.syncSns(
            egToken: egToken, principal: principal, profile: profile,
            success: {datas in
                print(datas)
                if let status = datas["status"] {
                    let result = String(describing: status)
                    if result == "COMPLETE"{
                        
                        MpInfo.Account.provider = provider
                        MpInfo.Account.email = email
                        
                        self.alert("sns sync가 성공되었습니다.")
                    } else if result == "FAILURE" {
                        //TODO 계정 연동 부분
                        self.alert("사용중인 sns 계정이 있습니다.")
                        /**
                         self.visibleSyncView(
                         snsEgId: String(describing: datas["duplicated"]!),
                         egToken: egToken,
                         profile: profile,
                         principal: principal,
                         provider: provider,
                         email: email
                         */
                    } else {
                        self.alert("알 수 없는 에러가 발생했습니다.")
                    }
                }
                //self.setupRightBarButtonItem()
        },
            fail: {error in self.alert(String(describing: error))}
        )
    }
    
    func onSignIn (_ success: Bool, _ provider: AWSSignInProvider) {
        // handle successful sign in
        if (success) {
            let profile = self.getProfile(identityProviderName: provider.identityProviderName)
            self.snsSyncProcess(profile.provider, profile.email)
            
        } else {
            // handle cancel operation from user
        }
    }
    
    func goToLogin() {
        if MpInfo.Account.isAuthedUser() == false {
            self.alert("게스트로 로그인이 먼저 필요합니다. \n\n게임시작을 먼저 해주세요.")
            return
        }
        print("Handling optional sign-in.")
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            let config = AWSAuthUIConfiguration()
            config.enableUserPoolsUI = false
            config.addSignInButtonView(class: AWSGoogleSignInButton.self)
            config.addSignInButtonView(class: AWSFacebookSignInButton.self)
            config.canCancel = true
            //with: self.navigationController!,
            AWSAuthUIViewController.presentViewController(
                with: self.navigationController!,
                configuration: config,
                completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                    if error != nil {
                        print("Error occurred: \(String(describing:error))")
                    } else {
                        self.onSignIn(true, provider)
                    }
            }
            )
        } else {
            self.alert("로그아웃 하시고 게스트 상태에서 다시 시도해주세요")
        }
    }
}

