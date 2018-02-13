//
//  BannerImageView.swift
//  banner
//
//  Created by estgames on 2018. 1. 16..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

//이미지 뷰
class BannerImageView: UIImageView {
    var bannerEntry: Entry?
    //var bannerName:String
    
    required init?(coder aDecoder: NSCoder) {
        self.bannerEntry = nil
        super.init(coder: aDecoder)
    }
    
    init(_ entry: Entry, viewWidth: CGFloat, viewHeight: CGFloat, bottomViewHeight: CGFloat) {
        self.bannerEntry = entry
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - bottomViewHeight))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self
            , action: #selector(imageViewClick))
        
        let imgUrl = URL(string: entry.banner.resource)
        let dtinternet = try? Data(contentsOf: imgUrl!)
        self.image = UIImage(data: dtinternet!)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageViewClick() {
        switch self.bannerEntry!.banner.action.type {
        case "WEB_VIEW":    //TODO 이미지 뷰처리..
            if let url = URL(string: self.bannerEntry!.banner.action.url) {
                UIApplication.shared.open(url, options: [:])
            }
        case "WEB_BROWSER" :
            if let url = URL(string: self.bannerEntry!.banner.action.url) {
                UIApplication.shared.open(url, options: [:])
            }
        default:
            //NONE
            print("NONE")
            
        }
    }
}
