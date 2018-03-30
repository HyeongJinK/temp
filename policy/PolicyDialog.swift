//
//  PolicyDialog.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 23..
//

import Foundation

public class PolicyDialog {
    var pview: UIViewController
    var policyViewController:PolicyViewController
    
    public init(pview: UIViewController) {
        self.pview = pview

        policyViewController = PolicyViewController()

        policyViewController.modalPresentationStyle = .overCurrentContext
    }
    
    //이용약관 다이얼로그
    public func show() {
        policyViewController.view.frame = CGRect(x: 41.5, y: 71.5, width: 522.5, height: 293.5)
        
        pview.present(policyViewController, animated: false)
    }
    
    public func dismiss() {
        policyViewController.removeFromParentViewController()
    }
}
