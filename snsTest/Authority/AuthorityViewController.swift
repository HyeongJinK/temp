//
//  AuthorityViewController.swift
//  snsTest
//
//  Created by estgames on 2018. 10. 1..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit
import WebKit

class AuthorityViewController: UIViewController {
    var backgroundView: UIView!
    var titleLabel: UILabel!
    var webView: WKWebView!
    var confirmButton: UIButton!
    var authorityDataSet: AuthorityDataSet!
    var webViewUrl: String? = nil
    var action : Action<String>?
    
    public func setAction(action : Action<String>) {
        self.action = action
    }
    public func setWebUrl (url: String?) {
        self.webViewUrl = url
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = "estcommon_authority_title".localized()
        confirmButton.setTitle("estcommon_authority_confirm".localized(), for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorityDataSet = AuthorityDataSet(self.view.frame.width, self.view.frame.height)
        
        backgroundView = UIView(frame: self.view.frame)
        titleLabel = UILabel(frame: authorityDataSet.titleLabel)
        webView = WKWebView(frame: authorityDataSet.webView)
        confirmButton = UIButton(frame: authorityDataSet.confirmButton)
        
        
        backgroundView.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 1)
        
        
        titleLabel.center.x = backgroundView.center.x
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        if let weburl = self.webViewUrl {
            if let url = URL(string: weburl) {
                webView.load(URLRequest(url: url))
            }
        }
        
        let confirmButtonImage:UIImage? = UIImage(named: "btn_confirm", in: Bundle(for: AuthorityViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        
        if let cbi = confirmButtonImage {
            confirmButton.setBackgroundImage(cbi, for: .normal)
        } else {
            confirmButton.backgroundColor = UIColor.darkGray
        }

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
        
        guard let action = action else {return }
        action.onDone("success")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
