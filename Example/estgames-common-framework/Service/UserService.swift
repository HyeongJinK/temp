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
    
    private func linkConfirmAction() {
        userLoadShow()
    }
    
    private func linkCancelAction() {
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
        let principal = accountService.getPrincipal()
        
        if let pi = principal {
            let device:String = "device_val@facdebook"
            self.accountService.createToken(
                principal: pi, device: device, profile: self.crashSnsSyncIno.profile,
                success: { data in
                    MpInfo.Account.provider = self.crashSnsSyncIno.provider
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
        } else {
            assert(false)
        }
    }
    
    func alert(_ message:String) -> Void{
        let alert = UIAlertController(title: "confirm", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        pview.present(alert, animated: true)
    }
}
