//
//  AuthorityViewController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 4. 6..
//

import UIKit

class AuthorityViewController: UIViewController {
    var backgroundView: UIView!
    var titleLabel: UILabel!
    var webView: UIWebView!
    var confirmButton: UIButton!
    var authorityDataSet: AuthorityDataSet!

    override func viewDidLoad() {
        super.viewDidLoad()
        authorityDataSet = AuthorityDataSet(deviceNum: DeviceClassification.deviceResolution(self.view.frame.width, self.view.frame.height))
        
        backgroundView = UIView(frame: self.view.frame)
        titleLabel = UILabel(frame: authorityDataSet.titleLabel)
        webView = UIWebView(frame: authorityDataSet.webView)
        confirmButton = UIButton(frame: authorityDataSet.confirmButton)
        
        
        backgroundView.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 1)
        
        
        titleLabel.text = NSLocalizedString("estcommon_authority_title", comment: "")
        titleLabel.center.x = backgroundView.center.x
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        let confirmButtonImage = UIImage(named: NSLocalizedString("estcommon_authority_confirm", comment: ""), in: Bundle(for: AuthorityViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        confirmButton.setBackgroundImage(confirmButtonImage, for: .normal)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        confirmButton.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(webView)
        backgroundView.addSubview(confirmButton)
    }

    @objc func closeBtAction(_ sender:UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
