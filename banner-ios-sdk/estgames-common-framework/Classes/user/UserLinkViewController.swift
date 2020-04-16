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
    //var closeButton: UIButton!
    var lineView: UIView!
    var middleLabel: UILabel!
    var bottomLabel: UILabel!
    var lineView2: UIView!
    var confirmButton: UserConfirmButton!
    var cancelButton: UIButton!
    var closeActon: () -> Void = {() -> Void in}
    var confirmAction: () -> Void = {() -> Void in}
    var cancelAction: () -> Void = {() -> Void in}
    var replaceStrSns: String = "[]"
    var replaceStrGuest: String = ""
    var replaceStrProvider: String = ""
    var buttonSize:CGFloat = 13
    var titleSize:CGFloat = 16
    var contentSize:CGFloat = 14
    var textlineSpacing:CGFloat = 9
    
    
    func dataSet(_ data:UserDataSet) {
        buttonSize = data.buttonSize
        titleSize = data.titleSize
        contentSize = data.contentSize
        textlineSpacing = data.textlineSpacing
        backgroudView = UIView(frame: data.userLinkBackgroudView!)
        userLinkTitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.userLinkCloseButton!)
        lineView = UIView(frame: data.userLinkLineView!)
        middleLabel = UILabel(frame: data.userLinkMiddleLabel!)
        bottomLabel = UILabel(frame: data.userLinkBottomLabel!)
        lineView2 = UIView(frame: data.userLinkLineView2!)
        confirmButton = UserConfirmButton(self, frame: data.userLinkConfirmButton!)
        cancelButton = UIButton(frame: data.userLinkCancelButton!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userLinkTitle.text = "estcommon_userLink_title".localized()
        
        middleLabel.font = UIFont.systemFont(ofSize: contentSize)
        middleLabel.numberOfLines = 0
        let middleText = "estcommon_userLink_middelLabel".localized().replacingOccurrences(of: "[]", with: replaceStrSns).replacingOccurrences(of: "Facebook", with: replaceStrProvider)
        let attrString = NSMutableAttributedString(string: middleText)
        
        middleText.enumerateSubstrings(in: middleText.startIndex..<middleText.endIndex, options: .byWords) {
            (substring, substringRange, _, _) in
            if substring == "\(self.replaceStrProvider)Account" {
                attrString.addAttribute(.foregroundColor, value: UIColor.blue,
                                              range: NSRange(substringRange, in: middleText))
            }
        }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = textlineSpacing // 아래 위로 전부 되서 18/2로 적용함  29 -> 20
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        bottomLabel.text = "estcommon_userLink_bottomLabel".localized().replacingOccurrences(of: "([])", with: replaceStrGuest)
        confirmButton.setTitle("estcommon_userLink_confirm".localized(), for: .normal)
        cancelButton.setTitle("estcommon_userLink_cancel".localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroudView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        userLinkTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userLinkTitle.font = UIFont.systemFont(ofSize: titleSize)
        
        
        closeButton.closeBtAction = closeActon
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        bottomLabel.font = UIFont.systemFont(ofSize: contentSize)
        
        
        lineView2.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 230/255, alpha: 1)
        
        confirmButton.confirmBtAction = confirmAction
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: buttonSize)
        
        
        let cancelButtonImg:UIImage? = UIImage(named: "btn_cancel_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        if let cbImg = cancelButtonImg {
            cancelButton.setBackgroundImage(cbImg, for: .normal)
        }
        cancelButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: buttonSize)
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
    public func replaceStr() {
        
        middleLabel.font = UIFont.systemFont(ofSize: contentSize)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: "estcommon_userLink_middelLabel".localized().replacingOccurrences(of: "[]", with: replaceStrSns).replacingOccurrences(of: "Facebook", with: replaceStrProvider))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9 // 아래 위로 전부 되서 18/2로 적용함
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
    }
//
//    @objc func closeBtAction(_ sender:UIButton) {
//        dismiss(animated: false, completion: closeActon)
//    }
    
    public func close() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func cancelBtAction(_ sender:UIButton) {
        self.dismiss(animated: false, completion: nil)
        cancelAction()
    }
    
}
