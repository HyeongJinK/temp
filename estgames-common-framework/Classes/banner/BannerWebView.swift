//
//  BannerWebView.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 6. 15..
//

import Foundation

class BannerWebView: UIWebView {
    public var bannerEntry: EventData?
    
    init(_ entry: EventData, viewWidth: CGFloat, viewHeight: CGFloat, bottomViewHeight: CGFloat) {
        self.bannerEntry = entry
        
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - bottomViewHeight))
        
        let url = URL(string: entry.banner.resource)
        
        if let urlcheck = url {
            self.loadRequest(URLRequest(url:urlcheck))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
