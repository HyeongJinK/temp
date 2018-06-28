//
//  bannerFramework.swift
//  banner
//
//  Created by estgames on 2018. 1. 10..
//  Copyright © 2018년 estgames. All rights reserved.
//
//로그인 화면 - 배경을 투명으로 만들고 버튼 올리기
import UIKit
import Foundation

var bannerView:BannerViewController?
var imageViews:[BannerView] = Array<BannerView>()
var imageViewsTemps:[BannerView] = Array<BannerView>()

public class bannerFramework {
    var estgamesBanner: ResultDataJson?
    var pview:UIViewController
    var closeBtCallBack: () -> Void = {() -> Void in }
    let myGroup = DispatchGroup()
    let bottomView:bannerBottomView
    
    
    public init(pview:UIViewController, result:ResultDataJson) {
        self.pview = pview
        self.estgamesBanner = result
        
        imageViews.removeAll()
        imageViewsTemps.removeAll()
        
        bannerView = BannerViewController()
        
        //bannerView = UIViewController(frame: CGRect(x: 0, y: 0, width: pview.view.frame.size.width, height: pview.view.frame.size.height))
        //bannerView?.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView = bannerBottomView() //아래바 생성
        
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let today = dateFormat.string(from: Date())
        
        let pList = UserDefaults.standard   //오늘만 보기 데이터
        
        for entry in self.estgamesBanner!.banner {
            if pList.string(forKey: entry.banner.name) != nil && today == pList.string(forKey: entry.banner.name)!{
                continue
            }

            //뷰 생성
            let bView = BannerView(entry
                , viewWidth: bannerView!.view.frame.size.width
                , viewHeight: bannerView!.view.frame.size.height
                , bottomViewHeight: bottomView.bottomViewHeight)
            imageViewsTemps.append(bView)
        }
        imageViewsTemps.reverse()
    }
    
    func createMainView(_ pview:UIView) -> UIView {
        //뷰 생성
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: pview.frame.size.width, height: pview.frame.size.height) //뷰 크기 창크기로
        
        return view
    }
    
    private func dataSetting() {
        //imageViewsTemps.removeAll()
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let today = dateFormat.string(from: Date())
        
        let pList = UserDefaults.standard   //오늘만 보기 데이터
        var remove = 0
        for (index, banner) in imageViewsTemps.enumerated() {
            if pList.string(forKey: banner.bannerEntry!.banner.name) != nil && today == pList.string(forKey: banner.bannerEntry!.banner.name)! {
                imageViewsTemps.remove(at: index-remove)
                remove += 1
            }
        }
    }
    
    public func count() -> Int {
        dataSetting()
        
        return imageViewsTemps.count
    }
    
    //배너 넣기 사용자가 호출해야 될 함수
    public func show() {
        //dataSet()
        // view 생성 , 창 크기에 맞게 조절
        //이미지 뷰 생성 , 창 크기에 맞게 조절
        //아래 바 생성
        //아래 바에 버튼 두 개 하루보기, 닫기
        dataSetting()
        
        if (imageViewsTemps.count > 0) {
            bottomView.closeBt.closeBtCallBack = closeBtCallBack
            
            self.pview.present(bannerView!, animated: false)
            //self.pview.view.addSubview(bannerView!)
            
            for img in imageViewsTemps {
                imageViews.append(img)
                bannerView!.view.addSubview(img.view)
            }
            
            if (imageViews.last?.bannerEntry?.banner.action.type == "NONE") {
                bottomView.linkBt.isHidden = true
            } else {
                bottomView.linkBt.setTitle(imageViews.last?.bannerEntry?.banner.action.button, for: .normal)
                bottomView.linkBt.isHidden = false
            }
            bottomView.oneDayLabel.text = "estcommon_banner_oneDay".localized()
            bannerView!.view.addSubview(bottomView)
        }
    }
}
