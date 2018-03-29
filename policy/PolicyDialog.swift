//
//  PolicyDialog.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 23..
//

import Foundation

public class PolicyDialog {
    //var policyDialog: UIAlertController;
    var pview: UIViewController
    var policyViewController:PolicyViewController
    
    public init(pview: UIViewController) {
        self.pview = pview
        
//        policyDialog = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        let widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: policyDialog.view.subviews[0], attribute:
//            NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 270)
//        policyDialog.view.subviews[0].addConstraint(widthConstraint)
        // 알림창에 뷰 컨트롤러를 등록한다.
        //policyDialog.setValue(policyViewController, forKey: "contentViewController")
        policyViewController = PolicyViewController()

        policyViewController.modalPresentationStyle = .overCurrentContext
    }
    
    //이용약관 다이얼로그
    public func show() {
        policyViewController.view.frame = CGRect(x: 41.5, y: 71.5, width: 522.5, height: 293.5)
        
        pview.present(policyViewController, animated: false)
        //pview.present(policyDialog, animated: false)
    }
    
    public func dismiss() {
        policyViewController.removeFromParentViewController()
        //policyDialog.dismiss(animated: false)
    }
}
