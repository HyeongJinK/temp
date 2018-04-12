//
//  ViewController.swift
//  estgames-common-framework
//
//  Created by wkzkfmxk23@gmail.com on 02/07/2018.
//  Copyright (c) 2018 wkzkfmxk23@gmail.com. All rights reserved.
//

import UIKit
import estgames_common_framework

class ViewController: UIViewController {
    let accountService = AccountService()
    
    var estgamesCommon:EstgamesCommon!
    
    var policy: PolicyDialog!
    var userLink: UserDialog!
    @IBAction func bannerTest(_ sender: Any) {
        estgamesCommon.bannerShow()
    }
    
    @IBAction func authorityTest(_ sender: Any) {
        estgamesCommon.authorityShow()
    }
    
    @IBAction func policyTest(_ sender: Any) {
        policy.show()
    }
    
    @IBAction func userLinkTest(_ sender: Any) {
        userLink.showUserLinkDialog()
    }
    
    @IBAction func UserLoadTest(_ sender: Any) {
        userLink.showUserLoadDialog()
    }
    
    @IBAction func UserResultTest(_ sender: Any) {
        userLink.showUserResultDialog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estgamesCommon = EstgamesCommon(pview: self)
        policy = PolicyDialog(pview: self)
        userLink = UserDialog(pview: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testttt(_ sender: Any) {
        print(estgamesCommon.estgamesData)
        print(policy.contract1())
        print(policy.contract2())
    }
    
    
    /**
     
     ***/
    
    
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
}

