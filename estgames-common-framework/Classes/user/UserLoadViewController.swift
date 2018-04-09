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
    var closeButton: UIButton!
    var lineView: UIView!
    var middleLabel: UILabel!
    var confirmLabel: UILabel!
    var inputButton: UIButton!
    var confirmButton: UIButton!
    
    func dataSet(_ data:UserDataSet) {
        backgroundView = UIView(frame: data.userLoadbackgroundView!)
        userLoadTitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.closeButton!)
        lineView = UIButton(frame: data.lineView!)
        middleLabel = UILabel(frame: data.userLoadMiddleLabel!)
        confirmLabel = UILabel(frame: data.userLoadConfirmLabel!)
        inputButton = UIButton(frame: data.userLoadInputButton!)
        confirmButton = UIButton(frame: data.userLoadConfirmButton!)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroundView.backgroundColor = UIColor.white
        
        userLoadTitle.text = NSLocalizedString("estcommon_userLoad_title", comment: "")
        userLoadTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userLoadTitle.font = UIFont.systemFont(ofSize: 12)
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        middleLabel.font = UIFont.systemFont(ofSize: 10)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string:NSLocalizedString("estcommon_userLoad_content", comment: ""))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        
        confirmLabel.text=NSLocalizedString("estcommon_userLoad_confirmText", comment: "")
        confirmLabel.font = UIFont.systemFont(ofSize: 10)
        confirmLabel.textColor = UIColor(red: 48/255, green: 127/255, blue: 1, alpha: 1)
        
        
        let inputButtonImg = UIImage(named: "img_inputbox_user", in: Bundle(for: UserLoadViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        inputButton.setBackgroundImage(inputButtonImg, for: .normal)
        inputButton.setTitleColor(UIColor(red: 126/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)
        inputButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        inputButton.setTitle(NSLocalizedString("estcommon_userLoad_input", comment: ""), for: .normal)
        
        let confirmButtonImg = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLoadViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        confirmButton.setBackgroundImage(confirmButtonImg, for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        confirmButton.setTitle(NSLocalizedString("estcommon_userLoad_confirmButton", comment: ""), for: .normal)
        
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(userLoadTitle)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(lineView)
        backgroundView.addSubview(middleLabel)
        backgroundView.addSubview(confirmLabel)
        backgroundView.addSubview(inputButton)
        backgroundView.addSubview(confirmButton)
    }
}
