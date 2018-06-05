//
//  UserLinkViewController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 3..
//

import Foundation

class UserLinkViewController: UIViewController {
    var backgroudView: UIView!
    var userLinkTitle: UILabel!
    var closeButton: UserCloseButton!
    var lineView: UIView!
    var middleLabel: UILabel!
    var bottomLabel: UILabel!
    var lineView2: UIView!
    var confirmButton: UserConfirmButton!
    var cancelButton: UIButton!
    var closeActon: () -> Void = {() -> Void in}
    var confirmAction: () -> Void = {() -> Void in}
    var cancelAction: () -> Void = {() -> Void in}
    var replaceStrSns: String = ""
    var replaceStrGuest: String = ""
    
    
    func dataSet(_ data:UserDataSet) {
        backgroudView = UIView(frame: data.userLinkBackgroudView!)
        userLinkTitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.userLinkCloseButton!)//x: backgroudView.frame.width - 16.5 - 14
        lineView = UIView(frame: data.userLinkLineView!)  //width: backgroundView.frame.width
        middleLabel = UILabel(frame: data.userLinkMiddleLabel!)
        bottomLabel = UILabel(frame: data.userLinkBottomLabel!)
        lineView2 = UIView(frame: data.userLinkLineView2!)
        confirmButton = UserConfirmButton(self, frame: data.userLinkConfirmButton!)
        cancelButton = UIButton(frame: data.userLinkCancelButton!)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroudView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        userLinkTitle.text = NSLocalizedString("estcommon_userLink_title", comment: "")
        userLinkTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userLinkTitle.font = UIFont.systemFont(ofSize: 12)
        //userLinkTitle.font = UIFont.init(name: "SqoqaHanSans", size: 12)
        
        
        closeButton.closeBtAction = closeActon
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        
        middleLabel.font = UIFont.systemFont(ofSize: 10)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: NSLocalizedString("estcommon_userLink_middelLabel", comment: "").replacingOccurrences(of: "[]", with: replaceStrSns))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9 // 아래 위로 전부 되서 18/2로 적용함
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        
        bottomLabel.text = NSLocalizedString("estcommon_userLink_bottomLabel", comment: "").replacingOccurrences(of: "[]", with: replaceStrGuest)
        bottomLabel.font = UIFont.systemFont(ofSize: 10)
        
        
        lineView2.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 230/255, alpha: 1)
        
        
        confirmButton.setTitle(NSLocalizedString("estcommon_userLink_confirm", comment: ""), for: .normal)
        confirmButton.confirmBtAction = confirmAction
        
        
        let cancelButtonImg:UIImage? = UIImage(named: "btn_cancel_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        if let cbImg = cancelButtonImg {
            cancelButton.setBackgroundImage(cbImg, for: .normal)
        }
        cancelButton.setTitle(NSLocalizedString("estcommon_userLink_cancel", comment: ""), for: .normal)
        cancelButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        cancelButton.addTarget(self, action: #selector(cancelBtAction(_:)), for: .touchUpInside)
        
        
        self.view.addSubview(backgroudView)
        backgroudView.addSubview(userLinkTitle)
        backgroudView.addSubview(closeButton)
        backgroudView.addSubview(lineView)
        backgroudView.addSubview(middleLabel)
        backgroudView.addSubview(bottomLabel)
        backgroudView.addSubview(lineView2)
        backgroudView.addSubview(confirmButton)
        backgroudView.addSubview(cancelButton)
    }
    
    @objc func cancelBtAction(_ sender:UIButton) {
        self.dismiss(animated: false, completion: nil)
        cancelAction()
    }
    
}
