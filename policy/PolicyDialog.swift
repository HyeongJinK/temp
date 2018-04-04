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
        //policyViewController.view.frame = CGRect(x: 41.5, y: 71.5, width: 522.5, height: 293.5)
        
        for name in UIFont.familyNames {
            print(name)
            if let nameString = name as? String
            {
                print(UIFont.fontNames(forFamilyName: nameString))
            }
        }
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
