//
//  BannerCloseBt.swift
//  banner
//
//  Created by estgames on 2018. 1. 16..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

//닫기 버튼
class CloseBt: UIButton {
    let closeBtTitle:String = "닫기"
    var bannerName:String = ""
    var checkBt: CheckBox?
    
    convenience init() {
        self.init(check: CheckBox(), bannerName: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(check: CheckBox, bannerName: String) {
        super.init(frame: CGRect.zero)
        
        self.bannerName = bannerName
        self.checkBt = check
        self.setTitle(closeBtTitle, for: .normal)
        self.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        // 체크 박스 유무 검사
        if self.checkBt!.isChecked == true {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            
            let pList = UserDefaults.standard
            pList.set(dateFormat.string(from: Date()), forKey: self.bannerName)
            pList.synchronize()
        }
        views.popLast()!.removeFromSuperview()
    }
}

