//
//  ViewController.swift
//  testapp
//
//  Created by estgames on 2018. 1. 10..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit
import banner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = bannerFramework()
        test.bannerAdd(pview: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

