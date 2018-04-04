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
    var closeButton: UIButton!
    var lineView: UIView!
    var middleLabel: UILabel!
    var bottomLabel: UILabel!
    var lineView2: UIView!
    var confirmButton: UIButton!
    var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        backgroudView = UIView(frame: CGRect(x: 23.5, y: 226, width: 328, height: 214))
        userLinkTitle = UILabel(frame: CGRect(x: 21.5, y: 15, width: 60, height: 12))
        closeButton = UIButton(frame: CGRect(x: 297.5, y: 12, width: 14, height: 14)) //x: backgroudView.frame.width - 16.5 - 14
        lineView = UIView(frame: CGRect(x: 0, y: 39, width: 328, height: 0.5))  //width: backgroundView.frame.width
        middleLabel = UILabel(frame: CGRect(x: 22, y: 50.5, width: 270, height: 66))
        bottomLabel = UILabel(frame: CGRect(x: 22, y: 132, width: 270, height: 10))
        lineView2 = UIView(frame: CGRect(x: 0, y: 158, width: 328, height: 0.5))
        confirmButton = UIButton(frame: CGRect(x: 18, y: 167, width: 142, height: 37))
        cancelButton = UIButton(frame: CGRect(x: 168, y: 167, width: 142, height: 37))
        
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.6)
        
        backgroudView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        userLinkTitle.text = "계정 연동"
        userLinkTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userLinkTitle.font = UIFont.systemFont(ofSize: 12)
        //userLinkTitle.font = UIFont.init(name: "SqoqaHanSans", size: 12)
        
        
        let closeButtonImg:UIImage = UIImage(named: "btn_close_img_user", in:Bundle(for: UserLinkViewController.self), compatibleWith:nil)!
        closeButton.setImage(closeButtonImg, for: .normal)
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        
        middleLabel.font = UIFont.systemFont(ofSize: 10)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: "입력하신 계정에 이미 플레이 중인 데이터가 있습니다.\nFacebookAccount: 기존게임닉네임, Lv._xx\n위의 데이터를 불러오시겠습니까?")
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9 // 아래 위로 전부 되서 18/2로 적용함
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        
        bottomLabel.text = "!현재 플레이 중인 게임데이터(현재게임닉네임, Lv.xx)는 삭제됩니다"
        bottomLabel.font = UIFont.systemFont(ofSize: 10)
        
        
        lineView2.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 230/255, alpha: 1)
        
        
        let confirmButtonImg = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        confirmButton.setBackgroundImage(confirmButtonImg, for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        confirmButton.setTitle("네, 불러오겠습니다", for: .normal)
        
        
        let cancelButtonImg = UIImage(named: "btn_cancel_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        cancelButton.setBackgroundImage(cancelButtonImg, for: .normal)
        cancelButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        cancelButton.setTitle("아니오, 새로 연동하기", for: .normal)
        
        
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
}



/**
 backgroudView = UIView(frame: CGRect(x: 159, y: 78, width: 370, height: 209.5))
 titleText = UILabel(frame: CGRect(x: 21.5, y: 15, width: 100, height: 12))
 closeButton = UIButton(frame: CGRect(x: 339.5, y: 12, width: 14, height: 14)) //x: backgroudView.frame.width - 16.5 - 14
 lineView = UIView(frame: CGRect(x: 0, y: 39, width: 370, height: 0.5))  //width: backgroundView.frame.width
 middleTextView = UILabel(frame: CGRect(x: 22, y: 59.5, width: 250, height: 66))
 bottomTextView = UILabel(frame: CGRect(x: 22, y: 142, width: 250, height: 10))
 lineView2 = UIView(frame: CGRect(x: 0, y: 152.5, width: 370, height: 0.5))
 confirmButton = UIButton(frame: CGRect(x: 18.5, y: 163.5, width: 163, height: 37))
 cancelButton = UIButton(frame: CGRect(x: 189.5, y: 163.5, width: 163, height: 37))
 */
