//
//  ViewController.swift
//  pod_gitlab_test
//
//  Created by wkzkfmxk23@gmail.com on 02/06/2018.
//  Copyright (c) 2018 wkzkfmxk23@gmail.com. All rights reserved.
//

import UIKit
import Alamofire
import pod_gitlab_test

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = BannerFramework()
        test.bannerAdd(pview: self.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

