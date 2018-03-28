//
//  PolicyController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 28..
//

import UIKit

class PolicyViewController: UIViewController {
    
    var titleLabel:UILabel!
    var submitBt: UIButton!
    
    override func viewDidLoad() {
        self.preferredContentSize.height = 500
        titleLabel = UILabel(frame: CGRect(x: 10, y: 50, width: 200, height: 57))
        titleLabel.text="원활한 게임플레이를 위해 아래 권한을 필요로 합니다."
        
        
        submitBt = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        submitBt.setTitle("확인", for: .normal)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(submitBt)
    }
}
