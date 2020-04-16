//
//  PolicyDialog.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 23..
//

import Foundation

class PolicyDialog {
    var pview: UIViewController
    var policyViewController:PolicyViewController
    
    public init(pview: UIViewController, callback: @escaping () -> Void) {
        self.pview = pview

        policyViewController = PolicyViewController()
        policyViewController.callbackFunc = callback
        policyViewController.modalPresentationStyle = .overCurrentContext
    }
    
    public init(pview: UIViewController) {
        self.pview = pview
        
        policyViewController = PolicyViewController()
        policyViewController.modalPresentationStyle = .overCurrentContext
    }
    
    //이용약관 다이얼로그
    public func show() {
        pview.present(policyViewController, animated: false)
    }
    
    public func dismiss() {
        policyViewController.dismiss(animated: false, completion: nil)
    }
    
    public func contract1() -> Bool {
        return policyViewController.submitBt1.isChecked
    }
    
    public func contract2() -> Bool {
        return policyViewController.submitBt2.isChecked
    }

}
