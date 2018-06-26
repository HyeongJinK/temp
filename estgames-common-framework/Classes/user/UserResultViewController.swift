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
    //var closeButton: UserCloseButton!//닫기
    var closeButton: UIButton!
    var lineView: UIView!
    var subLabel: UILabel!
    var contentLabel: UILabel!
    //var confirmButton: UserConfirmButton!
    var confirmButton: UIButton!
    var closeActon: (String?, String, String) -> Void = {(egId, type, provider) -> Void in}
    var confirmAction: (String?, String, String) -> Void = {(egId, type, provider) -> Void in}
    //var closeActon: () -> Void = {() -> Void in}
    //var confirmAction: () -> Void = {() -> Void in}
    var egId :String? = nil
    var resultType:String = "LOGIN"
    var provider:String = ""
    
    func dataSet(_ data:UserDataSet) {
        backgroundView = UIView(frame: data.userResultBackgroundView!)
        userResultTitle = UILabel(frame: data.titleLabel!)
        //closeButton = UserCloseButton(self, frame: data.closeButton!)
        closeButton = UIButton(frame: data.closeButton!)
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
        
        
        let closeButtonImage:UIImage? = UIImage(named: "btn_close_img_user", in:Bundle(for: UserCloseButton.self), compatibleWith:nil)
        if let cimg = closeButtonImage {
            closeButton.setImage(cimg, for: .normal)
        } else {
            closeButton.setTitle("X", for: .normal)
        }
        closeButton.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
        
        //closeButton.closeBtAction = closeActon
        
        
        lineView.backgroundColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1)
        
        subLabel.text = NSLocalizedString("estcommon_userResult_subTitle", comment: "")
        subLabel.font = UIFont.systemFont(ofSize: 12)
        subLabel.textColor = UIColor(red: 48/255, green: 122/255, blue: 245/255, alpha: 1)
        
        contentLabel.text = NSLocalizedString("estcommon_userResult_titleMove", comment: "")
        contentLabel.font = UIFont.systemFont(ofSize: 10)
        contentLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let confirmButtonImage:UIImage? = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        
        if let cimg = confirmButtonImage {
            self.confirmButton.setBackgroundImage(cimg, for: .normal)
        } else {
            self.confirmButton.backgroundColor = UIColor.gray
        }
        
        self.confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.confirmButton.addTarget(self, action: #selector(confirmBtAction(_:)), for: .touchUpInside)
        self.confirmButton.setTitle(NSLocalizedString("estcommon_userResult_confirm", comment: ""), for: .normal)
        
        //confirmButton.setTitle(NSLocalizedString("estcommon_userResult_confirm", comment: ""), for: .normal)
        //confirmButton.confirmBtAction = confirmAction
        
        
        backgroundView.addSubview(userResultTitle)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(lineView)
        backgroundView.addSubview(subLabel)
        backgroundView.addSubview(contentLabel)
        backgroundView.addSubview(confirmButton)
        self.view.addSubview(backgroundView)
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        closeActon(egId, resultType, provider)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func confirmBtAction(_ sender:UIButton) {
        confirmAction(egId, resultType, provider)
        self.dismiss(animated: false, completion: nil)
    }
}
