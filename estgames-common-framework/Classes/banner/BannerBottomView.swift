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
    var closeBt:CloseBt!
    let linkBt:LinkerButton = LinkerButton()
    let oneDayLabel:UILabel = UILabel()
    var linkbtFontSize:CGFloat = 13
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        switch (bannerView!.view.frame.size.width, bannerView!.view.frame.size.height) {
        case (768,1024), (834,1112) :
            bottomViewHeight = 86
            checkboxLeftMargin = 19; checkboxTopMargin = 22
            labelFontSize = 24;  linkbtFontSize = 26
            closebtWidth = 82; closebtHeight = 62
            closebtTopMargin = 12; closebtRightMargin = 19; closebtLiftMargin = 10
            linkbtWidth = 224; linkbtHeight = 62
            break;
        case (1024,1366):
            bottomViewHeight = 105
            checkboxLeftMargin = 23; checkboxTopMargin = 28
            labelFontSize = 30; linkbtFontSize = 32
            closebtWidth = 101; closebtHeight = 75
            closebtTopMargin = 15; closebtRightMargin = 23; closebtLiftMargin = 13
            linkbtWidth = 275; linkbtHeight = 75
            
            break
        default :
            break;
        }
        if (frame == CGRect.zero) {
            super.init(frame: CGRect(x: 0
                , y: bannerView!.view.frame.size.height - self.bottomViewHeight
                , width: bannerView!.view.frame.size.width
                , height: self.bottomViewHeight))
        } else {
            super.init(frame: frame)
        }
        self.backgroundColor = UIColor(red: 62/255, green: 65/255, blue: 71/255, alpha: 1.0)
        
        //체크박스
        let checkbox:CheckBox = CheckBox(leftMargin: checkboxLeftMargin, topMargin: checkboxTopMargin, width: bottomViewHeight - (checkboxTopMargin * 2), height: bottomViewHeight - (checkboxTopMargin * 2))
        self.addSubview(checkbox)
        
        //하루보기 레이블
        oneDayLabel.frame = CGRect(x: checkboxLeftMargin + checkboxRightMargin + bottomViewHeight - (checkboxTopMargin * 2), y: (bottomViewHeight-labelFontSize)/2, width: 300, height: labelFontSize)
        
        oneDayLabel.font = UIFont.boldSystemFont(ofSize: labelFontSize)
        oneDayLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        oneDayLabel.text = "estcommon_banner_oneDay".localized()
        self.addSubview(oneDayLabel)
        
        //닫기 버튼
        closeBt = CloseBt(check: checkbox, linkbt: linkBt)
        closeBt.frame = CGRect(x: self.frame.size.width - self.closebtWidth - self.closebtRightMargin
            , y: self.closebtTopMargin
            , width: self.closebtWidth
            , height: self.closebtHeight)
        
        //자세히 보기 버튼
        linkBt.frame = CGRect(x: closeBt.frame.origin.x - closebtLiftMargin - linkbtWidth, y: closebtTopMargin, width: linkbtWidth, height: linkbtHeight)
        linkBt.titleLabel?.font = UIFont.boldSystemFont(ofSize: linkbtFontSize)
        
        self.addSubview(linkBt)
        self.addSubview(closeBt)
    }
}
