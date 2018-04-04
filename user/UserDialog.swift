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
    
    public init(pview: UIViewController) {
        self.pview = pview
        userLinkViewController = UserLinkViewController()
        userLinkViewController.modalPresentationStyle = .overCurrentContext
        userLoadViewController = UserLoadViewController()
        userLoadViewController.modalPresentationStyle = .overCurrentContext
        userResultViewController = UserResultViewController()
        userResultViewController.modalPresentationStyle = .overCurrentContext
    }
    
    public func showUserLinkDialog() {
        pview.present(userLinkViewController, animated: false, completion: nil)
    }
    
    public func showUserLoadDialog() {
        pview.present(userLoadViewController, animated: false)
    }
    
    public func showUserResultDialog() {
        pview.present(userResultViewController, animated: false)
    }
}
