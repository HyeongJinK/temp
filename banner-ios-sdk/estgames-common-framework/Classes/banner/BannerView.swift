//
//  BannerView.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 6. 19..
//

import Foundation

class BannerView {
    public var bannerEntry: Banners?
    public var view: UIView!
    
    init(_ entry: Banners, viewWidth: CGFloat, viewHeight: CGFloat, bottomViewHeight: CGFloat) {
        self.bannerEntry = entry
        
        switch(entry.banner.content.type) {
            case "image/jpeg", "image/png", "image/PNG", "image/jpg", "image/JPG", "image/JPEG" :
                //이미지 뷰 생성
                let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - bottomViewHeight))
                imageView.backgroundColor = UIColor.white
                imageView.isUserInteractionEnabled = true
                imageView.contentMode = .scaleAspectFill
                //.scaleToFill
                //.scaleAspectFit
                //.scaleAspectFill
                let imgUrl = URL(string: entry.banner.content.resource)
                let dtinternet = try? Data(contentsOf: imgUrl!)
                if let itImg = dtinternet {
                    imageView.image = UIImage(data: itImg)
                }
                view = imageView
                break
            case "text/html":
                //이미지 뷰 생성
                let webView:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - bottomViewHeight))
                let url = URL(string: entry.banner.content.resource)
                //url = URL(string: "https://s3.ap-northeast-2.amazonaws.com/m-static.estgames.co.kr/mpsdk/ffg.global.ls/contract/privacy.html")
                
                if let urlcheck = url {
                    webView.loadRequest(URLRequest(url:urlcheck))
                }
                view = webView
                break
            default:
                view = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - bottomViewHeight))
                view.backgroundColor = UIColor.white
                break
        }
    }
}
