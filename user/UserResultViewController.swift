//
//  UserResultViewController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 3..
//

import Foundation

class UserResultViewController: UIViewController {
    var backgroundView: UIView!
    var userResultTitle: UILabel! //알림
    var closeButton: UIButton!//닫기
    var lineView: UIView!
    var subLabel: UILabel!
    var contentLabel: UILabel!
    var confirmButton: UIButton!
    
    func dataSet(_ data:UserDataSet) {
        backgroundView = UIView(frame: data.userResultBackgroundView!)
        userResultTitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.closeButton!)
        lineView = UIView(frame: data.lineView!)
        subLabel = UILabel(frame: data.userResultSubLabel!)
        contentLabel = UILabel(frame: data.userResultContentLabel!)
        confirmButton = UIButton(frame: data.userResultConfirmButton!)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroundView.backgroundColor = UIColor(red: 9, green: 9, blue: 9, alpha: 1)
        
        userResultTitle.text = "알림"
        userResultTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userResultTitle.font = UIFont.systemFont(ofSize: 12)
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        subLabel.text = "불러오기 성공"
        subLabel.font = UIFont.systemFont(ofSize: 12)
        subLabel.textColor = UIColor(red: 48/255, green: 122/255, blue: 245/255, alpha: 1)
        
        contentLabel.text = "게임 재 구동을 위해 타이틀 화면으로 이동합니다."
        contentLabel.font = UIFont.systemFont(ofSize: 10)
        contentLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let confirmButtonImg = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        confirmButton.setBackgroundImage(confirmButtonImg, for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        confirmButton.setTitle("확인", for: .normal)
        
        backgroundView.addSubview(userResultTitle)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(lineView)
        backgroundView.addSubview(subLabel)
        backgroundView.addSubview(contentLabel)
        backgroundView.addSubview(confirmButton)
        self.view.addSubview(backgroundView)
    }
}
