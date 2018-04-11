//
//  ViewController.swift
//  estgames-common-framework
//
//  Created by wkzkfmxk23@gmail.com on 02/07/2018.
//  Copyright (c) 2018 wkzkfmxk23@gmail.com. All rights reserved.
//

import UIKit
import estgames_common_framework

class ViewController: UIViewController {
    var policy: PolicyDialog!
    var userLink: UserDialog!
    @IBAction func bannerTest(_ sender: Any) {
        let banner = bannerFramework(pview: self);
        //banner.bottomViewHeight = 100;
        banner.show();
        //print(UIDevice.current.orientation.rawValue)
    }
    
    @IBAction func authorityTest(_ sender: Any) {
        let authDialog: AuthorityDialog = AuthorityDialog(pview: self)
        
        authDialog.show()
    }
    
    @IBAction func policyTest(_ sender: Any) {
        policy.show()
    }
    
    @IBAction func userLinkTest(_ sender: Any) {
        userLink.showUserLinkDialog()
    }
    
    @IBAction func UserLoadTest(_ sender: Any) {
        userLink.showUserLoadDialog()
    }
    
    @IBAction func UserResultTest(_ sender: Any) {
        userLink.showUserResultDialog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        policy = PolicyDialog(pview: self)
        userLink = UserDialog(pview: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testttt(_ sender: Any) {
        print(policy.contract1())
        print(policy.contract2())
    }
}

