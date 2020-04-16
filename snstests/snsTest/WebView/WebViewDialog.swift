//
//  WebViewDialog.swift
//  snsTest
//
//  Created by estgames on 2018. 10. 2..
//  Copyright © 2018년 estgames. All rights reserved.
//

import WebKit

private class WebViewDialog {
    var pview: UIViewController
    var webViewUIContoller: WebViewUIController
    
    
    public init(pview: UIViewController, egToken: String) {
        self.pview = pview
        
        webViewUIContoller = WebViewUIController()
        webViewUIContoller.egToken = egToken
        webViewUIContoller.modalPresentationStyle = .overCurrentContext
    }
    
    //이용약관 다이얼로그
    public func showFAQ() {
        webViewUIContoller.url = "https://m-stage.estgames.co.kr/cs/mr/dashboard"
        pview.present(webViewUIContoller, animated: false)
    }
    
    //이용약관 다이얼로그
    public func showNotice() {
        webViewUIContoller.url = "https://m-stage.estgames.co.kr/cs/"+MpInfo.App.appId+"/notices"
        pview.present(webViewUIContoller, animated: false)
    }
    
    public func dismiss() {
        webViewUIContoller.dismiss(animated: false, completion: nil)
    }
}
