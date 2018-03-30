//
//  PolicyCloseBt.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 29..
//

import Foundation

class PolicyCloseBt : UIButton {
    let closeBtImage:UIImage
    
    required init?(coder aDecoder: NSCoder) {
        closeBtImage = UIImage(named: "btn_close_img", in:Bundle(for: PolicyCloseBt.self), compatibleWith:nil)!
        super.init(coder: aDecoder)
    }
    
    init() {
        closeBtImage = UIImage(named: "btn_close_img", in:Bundle(for: PolicyCloseBt.self), compatibleWith:nil)!
        super.init(frame: CGRect.zero)
        
        //self.setImage(UIImage(, for: .highlighted)
        self.setImage(closeBtImage, for: .normal)
        self.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        print("taafaew")
    }
}
