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

    @IBAction func bannerTest(_ sender: Any) {
        var banner = bannerFramework(pview: self);
        //banner.bottomViewHeight = 100;
        banner.show();
        //print(UIDevice.current.orientation.rawValue)
    }
    
    @IBAction func policyTest(_ sender: Any) {
        var policy = PolicyDialog(pview: self)
        policy.show()
       // var policy = UIAlertController(
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

