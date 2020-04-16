//
//  PolicyButton.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 30..
//

import Foundation

class PolicyButton : UIButton {
    public var isChecked: Bool = false
    
    let checkImage:UIImage?
    let uncheckImage:UIImage?
    var checkBtCallBack: () -> Void = {() -> Void in }
    
    init(_ frames: CGRect) {
        uncheckImage = UIImage(named: "btn_provision_off", in:Bundle(for: PolicyButton.self), compatibleWith:nil)?.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        checkImage = UIImage(named: "btn_provision_on", in:Bundle(for: PolicyButton.self), compatibleWith:nil)?.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        //
        
        super.init(frame: frames)
        
        if let unimage = uncheckImage, let _ = checkImage {
            self.setBackgroundImage(unimage, for: .normal)
        } else {
            self.backgroundColor = UIColor.gray
        }
        
        self.setTitle("estcommon_policy_buttonText".localized(), for: .normal)
        self.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickEvent() {
        isChecked = !isChecked
        if let unimage = uncheckImage, let cImage = checkImage {
            if isChecked {
                self.setBackgroundImage(cImage, for: .normal)
            } else {
                self.setBackgroundImage(unimage, for: .normal)
            }
        } else {
            if isChecked {
                self.backgroundColor = UIColor.black
            } else {
                self.backgroundColor = UIColor.gray
            }
        }
        checkBtCallBack()
    }
}
