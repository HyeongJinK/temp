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
    
    override func viewDidLoad() {
        backgroundView = UIView(frame: CGRect(x: 23.5, y: 262.5, width: 328, height: 187))
        userLoadTitle = UILabel(frame: CGRect(x: 21.5, y: 15, width: 60, height: 12))
        closeButton = UIButton(frame: CGRect(x: 297.5, y: 12, width: 14, height: 14))
        lineView = UIButton(frame: CGRect(x: 0, y: 39, width: 328, height: 0.5))
        middleLabel = UILabel(frame: CGRect(x: 22, y: 50.5, width: 270, height: 66))
        confirmLabel = UILabel(frame: .zero)
        inputButton = UIButton(frame: CGRect(x: 19, y: 124, width: 209.5, height: 35))
        confirmButton = UIButton(frame: CGRect(x: 233.5, y: 124, width: 70, height: 35))
        
        
        
        backgroundView.backgroundColor = UIColor.white
        
        userLoadTitle.text = "기존 계정 불러오기"
        userLoadTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userLoadTitle.font = UIFont.systemFont(ofSize: 12)
        
        
        let closeButtonImg:UIImage = UIImage(named: "btn_close_img_user", in:Bundle(for: UserLoadViewController.self), compatibleWith:nil)!
        closeButton.setImage(closeButtonImg, for: .normal)
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        middleLabel.font = UIFont.systemFont(ofSize: 10)
        middleLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(string:"현재 게스트 모드로 플레이 중인 데이터(현재게임닉네임, Lv.xx)를\n삭제하고 기존 데이터를 불러오시려면 아래 문자를 입력해주세요.")
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attrString.length)) ////NSParagraphStyleAttributeName
        middleLabel.attributedText = attrString
        
        
        let inputButtonImg = UIImage(named: "img_inputbox_user", in: Bundle(for: UserLoadViewController.self), compatibleWith: nil)
        inputButton.setImage(inputButtonImg, for: .normal)
        inputButton.setTitleColor(UIColor(red: 126/255, green: 125/255, blue: 125/255, alpha: 1), for: .normal)
        inputButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        inputButton.setTitle("입력하기", for: .normal)
        
        let confirmButtonImg = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLoadViewController.self), compatibleWith: nil)
        confirmButton.setImage(confirmButtonImg, for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        confirmButton.setTitle("확인", for: .normal)
    }
}
