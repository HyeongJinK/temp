//
//  BannerCheckBox.swift
//  banner
//
//  Created by estgames on 2018. 1. 17..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

//체크상자
class CheckBox: UIButton {
    var x: CGFloat = 10
    var y: CGFloat = 0
    var width: CGFloat = 25
    var height: CGFloat = 25
    var isChecked: Bool = false
    
    let checkImage:UIImage
    let uncheckImage:UIImage
    
    convenience init() {
        self.init(frame: CGRect.zero, checkedCheckbox: "checked-checkbox-50", uncheckedCheckbox: "unchecked-checkbox-50")
    }
    
    required init?(coder aDecoder: NSCoder) {
        checkImage = UIImage(named: "checked-checkbox-50", in:Bundle(for: CheckBox.self), compatibleWith:nil)!
        uncheckImage = UIImage(named: "unchecked-checkbox-50", in:Bundle(for: CheckBox.self), compatibleWith:nil)!
        super.init(coder: aDecoder)
    }
    
    convenience init (checkedCheckbox: String = "checked-checkbox-50", uncheckedCheckbox: String = "unchecked-checkbox-50") {
        self.init(frame: CGRect.zero, checkedCheckbox: checkedCheckbox, uncheckedCheckbox: uncheckedCheckbox)
    }

    init(frame: CGRect, checkedCheckbox: String, uncheckedCheckbox: String) {
        checkImage = UIImage(named: checkedCheckbox, in:Bundle(for: CheckBox.self), compatibleWith:nil)!
        uncheckImage = UIImage(named: uncheckedCheckbox, in:Bundle(for: CheckBox.self), compatibleWith:nil)!
        
        if (frame == CGRect.zero) {
            super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        } else {
            super.init(frame:frame)
        }
        self.setImage(uncheckImage, for: .normal)
        self.addTarget(self, action: #selector(checkBoxClick), for: .touchUpInside)
    }
    
    @objc func checkBoxClick() {
        isChecked = !isChecked
        if isChecked {
            self.setImage(checkImage, for: .normal)
        } else {
            self.setImage(uncheckImage, for: .normal)
        }
    }
    
    public func unCheckInit() {
        isChecked = false
        self.setImage(uncheckImage, for: .normal)
    }
}
