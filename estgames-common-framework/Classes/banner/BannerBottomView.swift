//
//  BannerBottomView.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 2. 7..
//

import Foundation

class bannerBottomView: UIView {
    public var bottomViewHeight:CGFloat = 30
    var closeBtWidth:CGFloat = 50
    var closeBtheight:CGFloat = 25
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        if (frame == CGRect.zero) {
            super.init(frame: CGRect(x: 0
                , y: bannerView!.frame.size.height - self.bottomViewHeight
                , width: bannerView!.frame.size.width
                , height: self.bottomViewHeight))
        } else {
            super.init(frame: frame)
        }
        
        self.backgroundColor = UIColor.gray
        
        //체크박스, 레이블, 닫기 버튼
        let checkbox:CheckBox = CheckBox()
        self.addSubview(checkbox)
        
        //하루보기 레이블
        let oneDayLabel:UILabel = UILabel()
        oneDayLabel.frame = CGRect(x: 40, y: 0, width: 300, height: 25)
        oneDayLabel.text = "하루만보기"
        
        self.addSubview(oneDayLabel)
        //닫기 버튼
        let closeBt = CloseBt(check: checkbox)
        closeBt.frame = CGRect(x: self.frame.size.width - self.closeBtWidth
            , y: 0
            , width: self.closeBtWidth
            , height: self.closeBtheight)
        
        self.addSubview(closeBt)
        
    }
}
