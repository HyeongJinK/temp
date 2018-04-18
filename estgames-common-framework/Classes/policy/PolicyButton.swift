//
//  PolicyButton.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 30..
//

import Foundation

class PolicyButton : UIButton {
    public var isChecked: Bool = false
    
    let checkImage:UIImage
    let uncheckImage:UIImage
    var checkBtCallBack: () -> Void = {() -> Void in }
    
    init(_ frames: CGRect) {
        uncheckImage = UIImage(named: "btn_provision_off", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        checkImage = UIImage(named: "btn_provision_on", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        
        super.init(frame: frames)
        self.setBackgroundImage(uncheckImage, for: .normal)
        self.setTitle("동의합니다", for: .normal)
        self.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        uncheckImage = UIImage(named: "btn_provision_off", in:Bundle(for: PolicyButton.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        checkImage = UIImage(named: "btn_provision_on", in:Bundle(for: PolicyButton.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        super.init(coder: aDecoder)
    }
    
    @objc func clickEvent() {
        isChecked = !isChecked
        if isChecked {
            self.setBackgroundImage(checkImage, for: .normal)
        } else {
            self.setBackgroundImage(uncheckImage, for: .normal)
        }
        checkBtCallBack()
    }
}
