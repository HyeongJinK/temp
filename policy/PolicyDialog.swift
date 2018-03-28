//
//  PolicyDialog.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 23..
//

import Foundation

public class PolicyDialog {
    var policyDialog: UIAlertController;
    var pview: UIViewController
    
    public init(pview: UIViewController) {
        self.pview = pview
        policyDialog = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let policyViewController = PolicyViewController()
        
        // 알림창에 뷰 컨트롤러를 등록한다.
        policyDialog.setValue(policyViewController, forKey: "contentViewController")
    }
    
    //이용약관 다이얼로그
    public func show() {
        pview.present(policyDialog, animated: false)
    }
    
    public func dismiss() {
        policyDialog.dismiss(animated: false)
    }
}
