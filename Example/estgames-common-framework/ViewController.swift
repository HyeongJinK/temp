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

    override func viewDidLoad() {
        super.viewDidLoad()
        var banner = bannerFramework();
        banner.bannerAdd(pview: self.view);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

