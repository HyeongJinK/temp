//
//  BannerBottomView.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 2. 7..
//

import Foundation

class bannerBottomView: UIView {
    var bottomViewHeight:CGFloat = 42
    var checkboxLeftMargin:CGFloat = 9.5;
    var checkboxTopMargin:CGFloat = 11
    var checkboxRightMargin:CGFloat = 7.5
    
    var labelFontSize:CGFloat = 12
    
    var closebtLiftMargin:CGFloat = 4.5
    var closebtTopMargin:CGFloat = 7
    var closebtRightMargin:CGFloat = 9
    var closebtWidth:CGFloat = 38
    var closebtHeight:CGFloat = 30
    
    var linkbtWidth:CGFloat = 110
    var linkbtHeight:CGFloat = 31
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dataSet(DeviceNum: Int) {
        /**
         높이
         체크박스 왼쪽, 상단, 오른쪽 마진
         */
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
        
        self.backgroundColor = UIColor(red: 62/255, green: 65/255, blue: 71/255, alpha: 1.0)
        
        //체크박스
        let checkbox:CheckBox = CheckBox(leftMargin: checkboxLeftMargin, topMargin: checkboxTopMargin, width: bottomViewHeight - (checkboxTopMargin * 2), height: bottomViewHeight - (checkboxTopMargin * 2))
        self.addSubview(checkbox)
        
        //하루보기 레이블
        let oneDayLabel:UILabel = UILabel()
        
        oneDayLabel.frame = CGRect(x: checkboxLeftMargin + checkboxRightMargin + bottomViewHeight - (checkboxTopMargin * 2), y: (bottomViewHeight-labelFontSize)/2, width: 300, height: labelFontSize)
        
        oneDayLabel.font = UIFont.boldSystemFont(ofSize: labelFontSize)
        oneDayLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        oneDayLabel.text = "오늘 다시보지않기"
        //TODO 오토레이아웃 안됨...
//        isUserInteractionEnabled = false
//        oneDayLabel.translatesAutoresizingMaskIntoConstraints = false
//        let yCenterConstraint = NSLayoutConstraint(item: oneDayLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
//        oneDayLabel.addConstraint(yCenterConstraint)
        self.addSubview(oneDayLabel)
        
        //닫기 버튼
        let closeBt = CloseBt(check: checkbox)
        closeBt.frame = CGRect(x: self.frame.size.width - self.closebtWidth - self.closebtRightMargin
            , y: self.closebtTopMargin
            , width: self.closebtWidth
            , height: self.closebtHeight)
        
        self.addSubview(closeBt)
        
        //자세히 보기 버튼
        let linkBt = LinkerButton()
        linkBt.frame = CGRect(x: closeBt.frame.origin.x - closebtLiftMargin - linkbtWidth, y: closebtTopMargin, width: linkbtWidth, height: linkbtHeight)
        
        self.addSubview(linkBt)
    }
}
