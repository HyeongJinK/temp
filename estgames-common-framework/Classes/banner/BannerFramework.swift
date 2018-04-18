//
//  bannerFramework.swift
//  banner
//
//  Created by estgames on 2018. 1. 10..
//  Copyright © 2018년 estgames. All rights reserved.
//
//TODO 이용약관
//로그인 화면 - 배경을 투명으로 만들고 버튼 올리기
import UIKit
import Foundation



//var views:[UIView] = Array<UIView>()
var bannerView:UIView?
var imageViews:[BannerImageView] = Array<BannerImageView>()
var imageViewsTemps:[BannerImageView] = Array<BannerImageView>()

public class bannerFramework {
    var estgamesBanner: ResultDataJson?
    var pview:UIViewController
    let myGroup = DispatchGroup()
    
    
    public init(pview:UIViewController, result:ResultDataJson) {
        self.pview = pview
        self.estgamesBanner = result
        bannerView = UIView(frame: CGRect(x: 0, y: 0, width: pview.view.frame.size.width, height: pview.view.frame.size.height))
        bannerView?.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomView = bannerBottomView() //아래바 생성
        bannerView!.addSubview(bottomView)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let today = dateFormat.string(from: Date())
        
        let pList = UserDefaults.standard   //오늘만 보기 데이터
        
        for entry in self.estgamesBanner!.events {
            if pList.string(forKey: entry.banner.name) != nil && today == pList.string(forKey: entry.banner.name)!{
                continue
            }
            
            //이미지 뷰 생성
            let imageView = BannerImageView(entry, viewWidth: bannerView!.frame.size.width, viewHeight: bannerView!.frame.size.height ,                bottomViewHeight: bottomView.bottomViewHeight)
            imageViewsTemps.append(imageView)
        }
    }
    
    func createMainView(_ pview:UIView) -> UIView {
        //뷰 생성
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: pview.frame.size.width, height: pview.frame.size.height) //뷰 크기 창크기로
        
        return view
    }
    
    //배너 넣기 사용자가 호출해야 될 함수
    public func show() {
        //dataSet()
        // view 생성 , 창 크기에 맞게 조절
        //이미지 뷰 생성 , 창 크기에 맞게 조절
        //아래 바 생성
        //아래 바에 버튼 두 개 하루보기, 닫기
        self.pview.view.addSubview(bannerView!)
        
        for img in imageViewsTemps {
            imageViews.append(img)
            bannerView!.addSubview(img)
        }
        
    }
}
