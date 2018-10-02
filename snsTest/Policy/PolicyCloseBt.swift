//
//  PolicyCloseBt.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

class PolicyCloseBt : UIButton {
    let closeBtImage:UIImage?
    let viewC:PolicyViewController?
    var closeBtActionCallBack: ((String) -> Void)? = nil
    
    required init?(coder aDecoder: NSCoder) {
        closeBtImage = UIImage(named: "btn_close_img", in:Bundle(for: PolicyCloseBt.self), compatibleWith:nil)
        viewC = nil
        super.init(coder: aDecoder)
    }
    
    init(_ viewP:PolicyViewController) {
        viewC = viewP
        closeBtImage = UIImage(named: "btn_close_img", in:Bundle(for: PolicyCloseBt.self), compatibleWith:nil)
        super.init(frame: CGRect.zero)
        
        if let cImage = closeBtImage {
            self.setImage(cImage, for: .normal)
        } else {
            self.setTitle("X", for: .normal)
        }
        
        self.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        viewC!.dismiss(animated: false, completion: nil)
        guard let closeBtActionCallBack = closeBtActionCallBack else {return}
        closeBtActionCallBack("close")
    }
}
