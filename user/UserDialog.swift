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
    
    public init(pview: UIViewController) {
        self.pview = pview
        userLinkViewController = UserLinkViewController()
        userLinkViewController.modalPresentationStyle = .overCurrentContext
    }
    
    public func showUserLinkDialog() {
        pview.present(userLinkViewController, animated: false, completion: nil)
    }
    
    public func showUserLoadDialog() {
        
    }
    
    public func showUserResultDialog() {
        
    }
}
