//
//  ApiCallController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation

public class EstgamesCommon {
    var pview: UIViewController
    public var estgamesData: ResultDataJson!
    var banner:bannerFramework!
    var authority: AuthorityViewController
    
    let myGroup = DispatchGroup()
    
    public init(pview:UIViewController) {
        self.pview = pview
        
        authority = AuthorityViewController()
        authority.modalPresentationStyle = .overCurrentContext
        
        let url = "https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/live/start/ffg.global.ls"
        
        let alamo = request(url)
        self.myGroup.enter()
        alamo.responseJSON() {
            response in
            if let result = response.result.value {
                print("!")
                let bannerJson = result as! NSDictionary
                self.estgamesData = ResultDataJson(resultDataJson:bannerJson["ffg.global.ls"] as! NSDictionary)   //배너 파싱
                self.banner = bannerFramework(pview: pview, result: self.estgamesData);
                self.authority.setWebUrl(url: self.estgamesData.url.system_contract)
                self.myGroup.leave()
            } else {
                print("error")
            }
        }
    }
    
    //이용약관 다이얼로그
    public func authorityShow() {
        pview.present(authority, animated: false)
    }
    
    public func authorityDismiss() {
        authority.dismiss(animated: false, completion: nil)
    }
    
    public func bannerShow() {
        banner.show()
    }
}
