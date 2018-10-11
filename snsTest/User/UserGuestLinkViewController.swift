//
//  UserGuestLinkViewController.swift
//  snsTest
//
//  Created by estgames on 2018. 10. 1..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

class UserGuestLinkViewController: UIViewController {
    var backgroudView: UIView!
    var gltitle: UILabel!
    var closeButton: UserCloseButton!
    var lineView: UIView!
    var middleLabel: UILabel!
    var lineView2: UIView!
    var loginButton: UserConfirmButton!
    var beforeButton: UIButton!
    var closeActon: () -> Void = {() -> Void in}
    var loginAction: () -> Void = {() -> Void in}
    var beforeAction: () -> Void = {() -> Void in}
    var replaceStrSns: String = "[]"
    var replaceStrGuest: String = "[]"
    var titleSize:CGFloat = 16
    var contentSize:CGFloat = 14
    var buttonSize:CGFloat = 13
    var textlineSpacing:CGFloat = 9
    
    func dataSet(_ data:UserDataSet) {
        buttonSize = data.buttonSize
        titleSize = data.titleSize
        contentSize = data.contentSize
        textlineSpacing = data.textlineSpacing
        backgroudView = UIView(frame: data.userLinkBackgroudView!)
        gltitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.userLinkCloseButton!)//x: backgroudView.frame.width - 16.5 - 14
        lineView = UIView(frame: data.userLinkLineView!)  //width: backgroundView.frame.width
        middleLabel = UILabel(frame: data.userLinkMiddleLabel!)
        lineView2 = UIView(frame: data.userLinkLineView2!)
        loginButton = UserConfirmButton(self, frame: data.userLinkConfirmButton!)
        beforeButton = UIButton(frame: data.userLinkCancelButton!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gltitle.text = "estcommon_userGuest_title".localized()
        
        middleLabel.font = UIFont.systemFont(ofSize: contentSize)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: "estcommon_userGuest_middle".localized().replacingOccurrences(of: "[]", with: replaceStrSns) + "estcommon_userGuest_bottom".localized().replacingOccurrences(of: "[]", with: replaceStrGuest))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = textlineSpacing // 아래 위로 전부 되서 18/2로 적용함
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        loginButton.setTitle("estcommon_userGuest_loginBt".localized(), for: .normal)
        beforeButton.setTitle("estcommon_userGuest_beforeBt".localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroudView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        gltitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        gltitle.font = UIFont.systemFont(ofSize: titleSize)
        
        closeButton.closeBtAction = closeActon
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        lineView2.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 230/255, alpha: 1)
        
        loginButton.confirmBtAction = loginAction
        
        
        let cancelButtonImg:UIImage? = UIImage(named: "btn_cancel_user", in: Bundle(for: UserGuestLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        if let cbimg = cancelButtonImg {
            beforeButton.setBackgroundImage(cbimg, for: .normal)
        } else {
            beforeButton.backgroundColor = UIColor.gray
        }
        beforeButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        beforeButton.titleLabel?.font = UIFont.systemFont(ofSize: buttonSize)
        beforeButton.addTarget(self, action: #selector(beforeBtAction(_:)), for: .touchUpInside)
        
        
        self.view.addSubview(backgroudView)
        backgroudView.addSubview(gltitle)
        backgroudView.addSubview(closeButton)
        backgroudView.addSubview(lineView)
        backgroudView.addSubview(middleLabel)
        backgroudView.addSubview(lineView2)
        backgroudView.addSubview(loginButton)
        backgroudView.addSubview(beforeButton)
    }
    
    public func replaceStr () {
        middleLabel.font = UIFont.systemFont(ofSize: contentSize)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: "estcommon_userGuest_middle".localized().replacingOccurrences(of: "[]", with: replaceStrSns) + "estcommon_userGuest_bottom".localized().replacingOccurrences(of: "[]", with: replaceStrGuest))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = textlineSpacing // 아래 위로 전부 되서 18/2로 적용함
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
    }
    
    @objc func beforeBtAction(_ sender:UIButton) {
        self.dismiss(animated: false, completion: nil)
        beforeAction()
    }
}
