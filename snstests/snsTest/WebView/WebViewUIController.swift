//
//  WebViewUIController.swift
//  snsTest
//
//  Created by estgames on 2018. 10. 1..
//  Copyright © 2018년 estgames. All rights reserved.
//
import UIKit
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
    var action:Action<String>?
    
    public func setAction(action:Action<String>) {
        self.action = action
    }
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentedViewController != nil {
            super.dismiss(animated: flag, completion: completion)
        }
    }
    
    public override func viewDidLoad() {
        backgroundView = UIView(frame: self.view.frame)
        var y = 0
        if (self.view.frame.width.isEqual(to: 375) && self.view.frame.height.isEqual(to: 812)) {
            y = 42
        }
        closeBt = UIButton(frame: CGRect(x: Int(self.view.frame.width - 50), y: y, width: 50, height: 50))
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        backgroundView.backgroundColor = UIColor.black
        
        let closeButtonImage:UIImage? = UIImage(named: "btn_total_close_img", in:Bundle(for: WebViewUIController.self), compatibleWith:nil)
        
        if let img = closeButtonImage {
            closeBt.setImage(img, for: .normal)
        } else {
            closeBt.backgroundColor = UIColor.white
            closeBt.setTitle("닫기", for: .normal)
            closeBt.setTitleColor(UIColor.black, for: .normal)
        }
        
        closeBt.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        
        if (url != nil && egToken != nil) {
            url! += "?eg_token="+egToken!+"&lang="+nation
            webView.load(URLRequest(url: URL(string: url!)!))
        }
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(webView)
        backgroundView.addSubview(closeBt)
    }
    
    @objc func closeAction(_ sender:UIButton) {
        //self.dismiss(animated: false, completion: nil)
        super.dismiss(animated: false, completion: nil)
    }
}
