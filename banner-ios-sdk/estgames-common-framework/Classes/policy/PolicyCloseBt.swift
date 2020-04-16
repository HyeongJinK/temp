//
//  PolicyCloseBt.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 29..
//

import Foundation

class PolicyCloseBt : UIButton {
    let closeBtImage:UIImage?
    let viewC:PolicyViewController?
    var closeBtActionCallBack: (() -> Void)? = nil
    
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
            self.setBackgroundImage(cImage, for: .normal)
        } else {
            self.setTitle("X", for: .normal)
        }
        
        self.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        viewC!.dismiss(animated: false, completion: closeBtActionCallBack)
    }
}
