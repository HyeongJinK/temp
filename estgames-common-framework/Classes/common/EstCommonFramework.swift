//
//  ApiCallController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation

public class EstgamesCommon {
    let pview: UIViewController
    var estgamesData: ResultDataJson!
    var banner:bannerFramework!
    let authority: AuthorityViewController
    let policy: PolicyViewController
    
    let userLinkViewController: UserLinkViewController
    let userLoadViewController: UserLoadViewController
    let userResultViewController: UserResultViewController
    var userDataSet: UserDataSet!
    
    let myGroup = DispatchGroup()
    
    public init(pview:UIViewController) {
        self.pview = pview
        
        authority = AuthorityViewController()
        authority.modalPresentationStyle = .overCurrentContext
        
        policy = PolicyViewController()
        policy.modalPresentationStyle = .overCurrentContext
        
        userDataSet = UserDataSet(deviceNum: DeviceClassification.deviceResolution(pview.view.frame.width, pview.view.frame.height))
        userLinkViewController = UserLinkViewController()
        userLinkViewController.dataSet(userDataSet)
        userLinkViewController.modalPresentationStyle = .overCurrentContext
        userLoadViewController = UserLoadViewController()
        userLoadViewController.dataSet(userDataSet)
        userLoadViewController.modalPresentationStyle = .overCurrentContext
        userResultViewController = UserResultViewController()
        userResultViewController.dataSet(userDataSet)
        userResultViewController.modalPresentationStyle = .overCurrentContext
        
        let url = "https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/live/start/ffg.global.ls"
        
        self.myGroup.enter()
        request(url)
            .responseJSON() {
            response in
            if let result = response.result.value {
                let bannerJson = result as! NSDictionary
                print(bannerJson)
                self.estgamesData = ResultDataJson(resultDataJson:bannerJson["ffg.global.ls"] as! NSDictionary)   //배너 파싱
                
                
                print(self.estgamesData.errorMessage)
                if(self.estgamesData.errorMessage == nil) {
                    
                }
                
                self.banner = bannerFramework(pview: pview, result: self.estgamesData)
                self.authority.setWebUrl(url: self.estgamesData.url.system_contract)
                self.policy.setWebUrl(webUrl1: self.estgamesData.url.contract_service, webUrl2: self.estgamesData.url.contract_private)
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
    
    public func policyShow() {
        pview.present(policy, animated: false)
    }
    
    public func policyDismiss() {
        policy.dismiss(animated: false, completion: nil)
    }
    
    public func contractService() -> Bool {
        return policy.submitBt1.isChecked
    }
    
    public func contractPrivate() -> Bool {
        return policy.submitBt2.isChecked
    }
    
    public func bannerShow() {
        banner.show()
    }
    
    public func showUserLinkDialog() {
        pview.present(userLinkViewController, animated: false, completion: nil)
    }
    
    public func showUserLoadDialog() {
        pview.present(userLoadViewController, animated: false)
    }
    
    public func showUserResultDialog() {
        pview.present(userResultViewController, animated: false)
    }
}
