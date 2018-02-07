//
//  bannerFramework.swift
//  banner
//
//  Created by estgames on 2018. 1. 10..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit
import Foundation

var views:[UIView] = Array<UIView>()

public class bannerFramework: NSObject {
    var estgamesBanner: EstgamesBanner?
    let bottomViewHeight:CGFloat = 30
    let closeBtWidth:CGFloat = 50
    let closeBtheight:CGFloat = 25
    
    func createMainView(_ pview:UIView) -> UIView {
        //뷰 생성
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: pview.frame.size.width, height: pview.frame.size.height) //뷰 크기 창크기로
        
        return view
    }
    
    func bottomView() -> UIView {
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0
            , y: views.last!.frame.size.height - self.bottomViewHeight
            , width: views.last!.frame.size.width
            , height: self.bottomViewHeight)
        bottomView.backgroundColor = UIColor.gray
        
        return bottomView
    }
    
    //배너 넣기 사용자가 호출해야 될 함수
    public func bannerAdd(pview:UIView){
        // view 생성 , 창 크기에 맞게 조절
        //이미지 뷰 생성 , 창 크기에 맞게 조절
        //아래 바 생성
        //아래 바에 버튼 두 개 하루보기, 닫기
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let today = dateFormat.string(from: Date())
        
        let url = "https://8726wj937l.execute-api.ap-northeast-2.amazonaws.com/live?region=catcafe.kr.ls&lang=ko&placement=LANDING"
        
        let myGroup = DispatchGroup()
        
        let alamo = request(url)
        myGroup.enter()
        alamo.responseJSON() {
            response in
            if let result = response.result.value {
                let bannerJson = result as! NSDictionary
                
                self.estgamesBanner = EstgamesBanner(jsonData:bannerJson)   //배너 파싱
                myGroup.leave()
            } else {
                //TODO 받은 값이 없을 경우
            }
        }
        
        
        myGroup.notify(queue: .main) {
            for entry in self.estgamesBanner!.entries {
                let pList = UserDefaults.standard
                
                if pList.string(forKey: entry.banner.name) != nil && today == pList.string(forKey: entry.banner.name)!{
                    continue
                }

                views.append(self.createMainView(pview))
                pview.addSubview(views.last!)
                
                let imageView = BannerImageView(entry, viewWidth: views.last!.frame.size.width, viewHeight: views.last!.frame.size.height ,                bottomViewHeight: self.bottomViewHeight)
                views.last!.addSubview(imageView)
                
                //밑에 바 생성
                //임시로 뷰로 생성
                let bottomView = self.bottomView()
                
                //체크박스, 레이블, 닫기 버튼
                let checkbox:CheckBox = CheckBox()
                bottomView.addSubview(checkbox)
                
                //하루보기 레이블
                let oneDayLabel:UILabel = UILabel()
                oneDayLabel.frame = CGRect(x: 40, y: 0, width: 300, height: 25)
                oneDayLabel.text = "하루보기"
                
                bottomView.addSubview(oneDayLabel)
                //닫기 버튼
                // let closeBT - CGREct=CTll
                let closeBt = CloseBt(check: checkbox, bannerName: entry.banner.name)
                closeBt.frame = CGRect(x: bottomView.frame.size.width - self.closeBtWidth
                    , y: 0
                    , width: self.closeBtWidth
                    , height: self.closeBtheight)

                bottomView.addSubview(closeBt)
                
                views.last!.addSubview(bottomView)
                
            }
        }
    }
    
}
