//
//  UserService.swift
//  estgames-common-framework_Example
//
//  Created by estgames on 2018. 4. 16..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import Foundation
import estgames_common_framework
import AWSAuthUI
import AWSAuthCore

class UserService {
    var userDialog: UserDialog
    var crashSnsSyncIno = (snsEgId: "", egToken:"", profile:"", principal:"", provider: "", email: "")
    let accountService:AccountService = AccountService()
    let gameService:GameService = GameService()
    var pview: UIViewController
    
    init (p: UIViewController) {
        pview = p
        userDialog = UserDialog(pview: pview)
    }
    
    func isCognitoSnsLoggedIn() -> Bool {
        if AWSIdentityManager.default().logins().result == nil {
            return false
        } else {
            return true
        }
    }
    
    func getPrincipal() -> String? {
        return AWSIdentityManager.default().identityId
    }
    
    public  func refreshToken(
        egToken: String, refreshToken: String, device: String, profile: Any?,
        success: @escaping(_ data: Dictionary<String, Any>)-> Void,
        fail: @escaping(_ error: Error?)-> Void) {
        accountService.refreshToken(egToken: egToken, refreshToken: refreshToken, device: device, profile: profile, success: success, fail: fail)
    }
    
    private func linkConfirmAction() {  //sns계정 연동으로
        userLoadShow()
    }
    
    private func linkCancelAction() {   //기존 계정을 사용할 때(guest)
        syncForce()
        userResultShow()
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
        pview.present(alert, animated: true)
    }
}
