//
//  UserCloseButton.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 5..
//

import Foundation

class UserCloseButton : UIButton {
    var closeButtonImage: UIImage!
    var view: UIViewController?
    
    init(_ pview: UIViewController, frame: CGRect) {
        closeButtonImage = UIImage(named: "btn_close_img_user", in:Bundle(for: UserCloseButton.self), compatibleWith:nil)!
        view = pview
        super.init(frame: frame)
        
        self.setImage(closeButtonImage, for: .normal)
        self.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeBtAction(_ sender:UIButton) {
        view!.dismiss(animated: false, completion: nil)
    }
}
