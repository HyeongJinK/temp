//
//  UserLinkViewController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 3..
//

import Foundation

class UserLinkViewController: UIViewController {
    var backgroudView: UIView!
    var titleText: UITextView!
    var closeButton: UIButton!
    var lineView: UIView!
    var middleTextView: UITextView!
    var bottomTextView: UITextView!
    var lineView2: UIView!
    var confirmButton: UIButton!
    var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        backgroudView = UIView(frame: CGRect(x: 159, y: 78, width: 370, height: 209.5))
        titleText = UITextView(frame: CGRect(x: 21.5, y: 15, width: 100, height: 12))
        closeButton = UIButton(frame: CGRect(x: 339.5, y: 12, width: 14, height: 14)) //x: backgroudView.frame.width - 16.5 - 14
        lineView = UIView(frame: CGRect(x: 0, y: 39, width: 370, height: 0.5))  //width: backgroundView.frame.width
        middleTextView = UITextView(frame: CGRect(x: 22, y: 59.5, width: 250, height: 66))
        bottomTextView = UITextView(frame: CGRect(x: 22, y: 142, width: 250, height: 10))
        lineView2 = UIView(frame: CGRect(x: 0, y: 152.5, width: 370, height: 0.5))
        confirmButton = UIButton(frame: CGRect(x: 18.5, y: 163.5, width: 163, height: 37))
        cancelButton = UIButton(frame: CGRect(x: 189.5, y: 163.5, width: 163, height: 37))
        
        self.view.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 0.6)
        
        titleText.text = "계정 연동"
        titleText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleText.font = UIFont.systemFont(ofSize: 12)
    }
}
