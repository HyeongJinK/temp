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
