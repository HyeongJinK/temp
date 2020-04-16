//
//  BannerCloseBt.swift
//  snsTest
//
//  Created by estgames on 2018. 10. 1..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

class CloseBt: UIButton {
    let closeBtTitle:String = "estcommon_banner_closeButton".localized()
    var checkBt: CheckBox?
    var linkBt: LinkerButton?
    let closeBtImage:UIImage?
    var closeBtCallBack: () -> Void = {() -> Void in }
    
    required init?(coder aDecoder: NSCoder) {
        closeBtImage = UIImage(named: "btn_bottom_close_img", in:Bundle(for: CloseBt.self), compatibleWith:nil)
        super.init(coder: aDecoder)
    }
    
    init(check: CheckBox, linkbt: LinkerButton) {
        closeBtImage = UIImage(named: "btn_bottom_close_img", in:Bundle(for: CloseBt.self), compatibleWith:nil)
        
        super.init(frame: CGRect.zero)
        
        self.checkBt = check
        self.linkBt = linkbt
        self.setImage(closeBtImage, for: .normal)
        self.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        // 체크 박스 유무 검사
        if self.checkBt!.isChecked == true {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            
            let pList = UserDefaults.standard
            let last: BannerView = imageViews.last!
            pList.set(dateFormat.string(from: Date()), forKey: last.bannerEntry!.banner.name)
            pList.synchronize()
        }
        self.checkBt!.unCheckInit()
        imageViews.popLast()!.view.removeFromSuperview()
        if (imageViews.last?.bannerEntry?.banner.action.type == "NONE") {
            self.linkBt!.isHidden = true
        } else {
            self.linkBt!.setTitle(imageViews.last?.bannerEntry?.banner.action.button, for: .normal)
            self.linkBt!.isHidden = false
        }
        
        if (imageViews.isEmpty) {
            closeBtCallBack()
            bannerView!.dismiss(animated: false, completion: nil)
        }
    }
}
