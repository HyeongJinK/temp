//
//  UserConfirmButton.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 16..
//

import Foundation

class UserConfirmButton : UIButton {
    var confirmButtonImage: UIImage?
    var view: UIViewController?
    var confirmBtAction: () -> Void = {() -> Void in}
    
    init(_ pview: UIViewController, frame: CGRect) {
        confirmButtonImage = UIImage(named: "btn_confirm_user", in: Bundle(for: UserLinkViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        view = pview
        super.init(frame: frame)
        
        self.setBackgroundImage(confirmButtonImage, for: .normal)
        self.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addTarget(self, action: #selector(confirmBtAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func confirmBtAction(_ sender:UIButton) {
        view!.dismiss(animated: false, completion: nil)
        confirmBtAction()
    }
}
