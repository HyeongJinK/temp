//
//  BannerBottomView.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 2. 7..
//

import Foundation

class bannerBottomView: UIView {
    public var bottomViewHeight:CGFloat = 30
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        if (frame == CGRect.zero) {
            super.init(frame: CGRect(x: 0
                , y: views.last!.frame.size.height - self.bottomViewHeight
                , width: views.last!.frame.size.width
                , height: self.bottomViewHeight))
        } else {
            super.init(frame: frame)
        }
        
        self.backgroundColor = UIColor.gray
    }
}
