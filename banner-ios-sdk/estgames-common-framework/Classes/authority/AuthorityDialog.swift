//
//  AuthorityDialog.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 6..
//

import Foundation

class AuthorityDialog {
    var pview: UIViewController
    var authority: AuthorityViewController
    
    public init(pview: UIViewController, callback: @escaping () -> Void ) {
        self.pview = pview
        
//        let storyboard: UIStoryboard = UIStoryboard(name: "authorityStoryboard", bundle: nil)
//        authority = storyboard.instantiateInitialViewController()!
        
        authority = AuthorityViewController()
        authority.callbackFunc = callback
        authority.modalPresentationStyle = .overCurrentContext
    }
    
    public init(pview: UIViewController) {
        self.pview = pview
        
        authority = AuthorityViewController()
        authority.modalPresentationStyle = .overCurrentContext
    }
    
    //이용약관 다이얼로그
    public func show() {
        pview.present(authority, animated: false)
    }
    
    public func dismiss() {
        authority.dismiss(animated: false, completion: nil)
    }
}
