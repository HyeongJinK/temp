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
    var webViewUrl: String? = nil
    var callbackFunc:() -> Void = {() -> Void in}
    
    public func setWebUrl (url: String) {
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
        webView = UIWebView(frame: authorityDataSet.webView)
        confirmButton = UIButton(frame: authorityDataSet.confirmButton)
        
        
        backgroundView.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 1)
        
        
        titleLabel.center.x = backgroundView.center.x
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: authorityDataSet!.titleFontSize)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        if let weburl = self.webViewUrl {
            if let url = URL(string: weburl) {
                    webView.loadRequest(URLRequest(url: url))
            }
        }
        
        let confirmButtonImage:UIImage? = UIImage(named: "btn_confirm", in: Bundle(for: AuthorityViewController.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        
        if let cbi = confirmButtonImage {
            confirmButton.setBackgroundImage(cbi, for: .normal)
        } else {
            confirmButton.backgroundColor = UIColor.darkGray
        }
//        confirmButton.setTitle("estcommon_authority_confirm".localized(), for: .normal)
        confirmButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: authorityDataSet!.buttonFontSize)
        confirmButton.addTarget(self, action: #selector(closeBtAction(_:)), for: .touchUpInside)
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(webView)
        backgroundView.addSubview(confirmButton)
    }

    @objc func closeBtAction(_ sender:UIButton) {
        self.dismiss(animated: false, completion: callbackFunc)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
