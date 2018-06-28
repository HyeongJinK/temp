//
//  UserLoadViewController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 3..
//

import Foundation

class UserLoadViewController: UIViewController {
    var backgroundView: UIView!
    var userLoadTitle: UILabel!
    var closeButton: UserCloseButton!
    var lineView: UIView!
    var middleLabel: UILabel!
    var confirmLabel: UILabel!
    var inputText: UITextField!
    var confirmButton: UIButton!
    var closeActon: () -> Void = {() -> Void in}
    var confirmCheck: () -> Bool = {() -> Bool in return true}
    var confirmActionCallBack: () -> Void = {() -> Void in}
    var replaceMiddleStr:String = ""
    
    func dataSet(_ data:UserDataSet) {
        backgroundView = UIView(frame: data.userLoadbackgroundView!)
        userLoadTitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.closeButton!)
        lineView = UIButton(frame: data.lineView!)
        middleLabel = UILabel(frame: data.userLoadMiddleLabel!)
        confirmLabel = UILabel(frame: data.userLoadConfirmLabel!)
        inputText = UITextField(frame: data.userLoadInputButton!)
        confirmButton = UIButton(frame: data.userLoadConfirmButton!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userLoadTitle.text = "estcommon_userLoad_title".localized()
        
        middleLabel.font = UIFont.systemFont(ofSize: 10)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string:"estcommon_userLoad_content".localized().replacingOccurrences(of: "([])", with: replaceMiddleStr))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        confirmLabel.text = "estcommon_userLoad_confirmText".localized()
        
        inputText.attributedPlaceholder = NSAttributedString(string: "estcommon_userLoad_input".localized())
        confirmButton.setTitle("estcommon_userLoad_confirmButton".localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroundView.backgroundColor = UIColor.white
        
//        userLoadTitle.text = "estcommon_userLoad_title".localized()
        userLoadTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userLoadTitle.font = UIFont.systemFont(ofSize: 12)
        
        
        closeButton.closeBtAction = closeActon
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
//        middleLabel.font = UIFont.systemFont(ofSize: 10)
//        middleLabel.numberOfLines = 0
//        let attrString = NSMutableAttributedString(string:"estcommon_userLoad_content".localized().replacingOccurrences(of: "([])", with: replaceMiddleStr))
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 9
//        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
//        middleLabel.attributedText = attrString
        
        
//        confirmLabel.text = "estcommon_userLoad_confirmText".localized()
        confirmLabel.font = UIFont.systemFont(ofSize: 10)
        confirmLabel.textColor = UIColor(red: 48/255, green: 127/255, blue: 1, alpha: 1)
        
        
        let inputButtonImg:UIImage? = UIImage(named: "img_inputbox_user", in: Bundle(for: UserLoadViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        if let ibimg = inputButtonImg {
            inputText.background = ibimg
        }
        inputText.textColor = UIColor(red: 126/255, green: 125/255, blue: 125/255, alpha: 1)
//        inputText.attributedPlaceholder = NSAttributedString(string: "estcommon_userLoad_input".localized())
        inputText.textAlignment = .center
        //inputText.addTarget(self, action: #selector(editBegin), for: .editingDidBegin)

        let confirmButtonImage:UIImage? = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        if let cbimg = confirmButtonImage {
            confirmButton.setBackgroundImage(cbimg, for: .normal)
        }
//        confirmButton.setTitle("estcommon_userLoad_confirmButton".localized(), for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        confirmButton.addTarget(self, action: #selector(confirmBtAction(_:)), for: .touchUpInside)
        
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(userLoadTitle)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(lineView)
        backgroundView.addSubview(middleLabel)
        backgroundView.addSubview(confirmLabel)
        backgroundView.addSubview(inputText)
        backgroundView.addSubview(confirmButton)
    }
    
    public func replaceStr() {
        middleLabel.font = UIFont.systemFont(ofSize: 10)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string:"estcommon_userLoad_content".localized().replacingOccurrences(of: "([])", with: replaceMiddleStr))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
    }
    
    @objc func confirmBtAction(_ sender:UIButton) {
        if (confirmCheck()) {
            self.dismiss(animated: false, completion: nil)
            confirmActionCallBack()
        } else {
            inputText.text = ""
            inputText.attributedPlaceholder = NSAttributedString(string: "estcommon_userLoad_input_wrong".localized())
        }
    }
    
    @objc func editBegin() {
        inputText.text = ""
    }
}
