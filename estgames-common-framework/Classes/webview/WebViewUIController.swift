//
//  WebViewUIController.swift
//
//  Created by estgames on 2018. 4. 18..
//

import Foundation
import WebKit

public class WebViewUIController: UIViewController {
    var backgroundView: UIView!
    //닫기 버튼
    var closeBt: UIButton!
    //웹뷰
    var webView: WKWebView!
    var url: String?
    var egToken: String?
    var nation: String="en"
    
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentedViewController != nil {
            super.dismiss(animated: flag, completion: completion)
        }
    }
    
    public override func viewDidLoad() {
        //print(self.view.frame)
        backgroundView = UIView(frame: self.view.frame)
        closeBt = UIButton(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 50))
        webView = WKWebView(frame: CGRect(x: 0, y: 81, width: self.view.frame.width, height: self.view.frame.height - 60))
        
        backgroundView.backgroundColor = UIColor.black
        
        closeBt.backgroundColor = UIColor.white
        closeBt.setTitle("닫기", for: .normal)
        closeBt.setTitleColor(UIColor.black, for: .normal)
        closeBt.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        
        if (url != nil && egToken != nil) {
            url! += "?eg_token="+egToken!+"&lang="+nation
            webView.load(URLRequest(url: URL(string: url!)!))
        }
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(closeBt)
        backgroundView.addSubview(webView)
    }
    
    @objc func closeAction(_ sender:UIButton) {
        //self.dismiss(animated: false, completion: nil)
        super.dismiss(animated: false, completion: nil)
    }
}
