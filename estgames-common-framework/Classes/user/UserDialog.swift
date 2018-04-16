//
//  UserDialog.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 3..
//

import Foundation

public class UserDialog {
    let pview: UIViewController
    let userLinkViewController: UserLinkViewController
    let userLoadViewController: UserLoadViewController
    let userResultViewController: UserResultViewController
    var userDataSet: UserDataSet
    
    // 이전 login controller로 부터 전달 받을 sns 계정 데이터 튜플
    var crashSnsSyncIno = (snsEgId: "", egToken:"", profile:"", principal:"", provider: "", email: "")
    
    public init(pview: UIViewController) {
        self.pview = pview
        userDataSet = UserDataSet(deviceNum: DeviceClassification.deviceResolution(pview.view.frame.width, pview.view.frame.height))
        userLinkViewController = UserLinkViewController()
        userLinkViewController.dataSet(userDataSet)
        userLinkViewController.modalPresentationStyle = .overCurrentContext
        userLoadViewController = UserLoadViewController()
        userLoadViewController.dataSet(userDataSet)
        userLoadViewController.modalPresentationStyle = .overCurrentContext
        userResultViewController = UserResultViewController()
        userResultViewController.dataSet(userDataSet)
        userResultViewController.modalPresentationStyle = .overCurrentContext
    }
    
    public func setUserLinkAction(closeAction: @escaping () -> Void, confirmAction:@escaping () -> Void, cancelAction: @escaping () -> Void) {
        self.userLinkViewController.closeActon = closeAction
        self.userLinkViewController.confirmAction = confirmAction
        self.userLinkViewController.cancelAction = cancelAction
    }
    
    public func setUserLoadAction(closeAction: @escaping () -> Void, confirmCheck:@escaping () -> Bool, confirmActionCallBack: @escaping () -> Void) {
        self.userLoadViewController.closeActon = closeAction
        self.userLoadViewController.confirmCheck = confirmCheck
        self.userLoadViewController.confirmActionCallBack = confirmActionCallBack
    }
    
    public func setUserResultction(closeAction: @escaping () -> Void, confirmAction:@escaping () -> Void) {
        self.userResultViewController.closeActon = closeAction
        self.userResultViewController.confirmAction = confirmAction
    }
    
    public func setUserLinkCharacterLabel(guest: String, sns: String) {
        self.userLinkViewController.replaceStrSns = sns
        self.userLinkViewController.replaceStrGuest = guest
    }
    
    public func setUserLoadCharacterLabel(guest: String) {
        self.userLoadViewController.middleLabel.text = self.userLoadViewController.middleLabel.text!.replacingOccurrences(of: "[]", with: guest)
    }
    
    public func showUserLinkDialog() {
        pview.present(userLinkViewController, animated: false, completion: nil)
    }
    
    public func showUserLoadDialog() {
        pview.present(userLoadViewController, animated: false)
    }
    
    public func getConfirmText() -> String {
        return userLoadViewController.inputText.text!
    }
    
    public func showUserResultDialog() {
        pview.present(userResultViewController, animated: false)
    }
    
    public func getInputText() -> String? {
        return userLoadViewController.inputText.text
    }
}
