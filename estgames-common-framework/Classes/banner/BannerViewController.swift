//
//  BannerViewController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 6. 22..
//

import Foundation

//var imageViews:[BannerView] = Array<BannerView>()
//var imageViewsTemps:[BannerView] = Array<BannerView>()

class BannerViewController: UIViewController {
    var backgroudView:UIView!
    var estgamesBanner: ResultDataJson?
    var bottomView:bannerBottomView?
    var callbackFunc:() -> Void = {() -> Void in}
    
    init(result:ResultDataJson) {
        self.estgamesBanner = result
        //super.init(coder: NSCoder())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        imageViews.removeAll()
        imageViewsTemps.removeAll()
        
        backgroudView = UIView(frame: self.view.frame)
        
        bottomView = bannerBottomView() //아래바 생성
        backgroudView.addSubview(bottomView)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let today = dateFormat.string(from: Date())
        
        let pList = UserDefaults.standard   //오늘만 보기 데이터
        
//        for entry in self.estgamesBanner!.banner {
//            if pList.string(forKey: entry.banner.name) != nil && today == pList.string(forKey: entry.banner.name)!{
//                continue
//            }
//
//            //뷰 생성
//            let bView = BannerView(entry
//                , viewWidth: bannerView!.frame.size.width
//                , viewHeight: bannerView!.frame.size.height
//                , bottomViewHeight: bottomView.bottomViewHeight)
//            imageViewsTemps.append(bView)
//        }
//        imageViewsTemps.reverse()
        
        self.view.addSubview(backgroudView)
    }
}
