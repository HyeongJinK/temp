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
    var closeButton: UserCloseButton!//닫기
    var lineView: UIView!
    var subLabel: UILabel!
    var contentLabel: UILabel!
    var confirmButton: UserConfirmButton!
    var closeActon: () -> Void = {() -> Void in}
    var confirmAction: () -> Void = {() -> Void in}
    
    func dataSet(_ data:UserDataSet) {
        backgroundView = UIView(frame: data.userResultBackgroundView!)
        userResultTitle = UILabel(frame: data.titleLabel!)
        closeButton = UserCloseButton(self, frame: data.closeButton!)
        lineView = UIView(frame: data.lineView!)
        subLabel = UILabel(frame: data.userResultSubLabel!)
        contentLabel = UILabel(frame: data.userResultContentLabel!)
        confirmButton = UserConfirmButton(self, frame: data.userResultConfirmButton!)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.8)
        
        backgroundView.backgroundColor = UIColor(red: 9, green: 9, blue: 9, alpha: 1)
        
        userResultTitle.text = NSLocalizedString("estcommon_userResult_title", comment: "")
        userResultTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        userResultTitle.font = UIFont.systemFont(ofSize: 12)
        
        
        closeButton.closeBtAction = closeActon
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        subLabel.text = NSLocalizedString("estcommon_userResult_subTitle", comment: "")
        subLabel.font = UIFont.systemFont(ofSize: 12)
        subLabel.textColor = UIColor(red: 48/255, green: 122/255, blue: 245/255, alpha: 1)
        
        contentLabel.text = NSLocalizedString("estcommon_userResult_titleMove", comment: "")
        contentLabel.font = UIFont.systemFont(ofSize: 10)
        contentLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        confirmButton.setTitle(NSLocalizedString("estcommon_userResult_confirm", comment: ""), for: .normal)
        confirmButton.confirmBtAction = confirmAction
        
        
        backgroundView.addSubview(userResultTitle)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(lineView)
        backgroundView.addSubview(subLabel)
        backgroundView.addSubview(contentLabel)
        backgroundView.addSubview(confirmButton)
        self.view.addSubview(backgroundView)
    }
}
