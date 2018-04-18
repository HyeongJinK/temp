//
//  ApiCallController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation

public class EstgamesCommon {
    let pview: UIViewController
    var estgamesData: ResultDataJson?
    var banner:bannerFramework!
    let authority: AuthorityViewController
    public var authorityCallBack : () -> Void = { () -> Void in}
    public var policyCallBack : () -> Void = { () -> Void in}
    let policy: PolicyViewController
    var process: [String] = Array<String>()
    
    let myGroup = DispatchGroup()
    
    public init(pview:UIViewController) {
        self.pview = pview
        
        authority = AuthorityViewController()
        authority.modalPresentationStyle = .overCurrentContext
        
        policy = PolicyViewController()
        policy.modalPresentationStyle = .overCurrentContext
        
        dataSet(pview: pview)
    }
    
    private func dataSet(pview:UIViewController) {
        
        let url = "https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/live/start/ffg.global.ls"
        
        let manager = SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        self.myGroup.enter()
        manager.request(url)
            .responseJSON() {
                response in
                if let result = response.result.value {
                    let bannerJson = result as! NSDictionary
                    
                    if ((bannerJson["errorMessage"] as? String) != nil){
                        print(bannerJson)
                    } else {
                        self.estgamesData = ResultDataJson(resultDataJson:bannerJson["ffg.global.ls"] as! NSDictionary)   //배너 파싱
                        self.authority.setWebUrl(url: self.estgamesData!.url.system_contract)
                        self.banner = bannerFramework(pview: pview, result: self.estgamesData!)
                        self.policy.setWebUrl(webUrl1: self.estgamesData!.url.contract_service, webUrl2: self.estgamesData!.url.contract_private)
                        self.process = self.estgamesData!.process[self.estgamesData!.nation] as! Array<String>
                    }
                    self.myGroup.leave()
                } else {
                    print("error")
                }
        }
    }
    
    public func processShow() {
        print(self.process.count)
        print(self.process[0])
    }
    
    private func checkEstgamesData(){
        if estgamesData == nil {
            dataSet(pview: self.pview)
        }
    }
    
    //이용약관 다이얼로그
    public func authorityShow() {
        checkEstgamesData()
        
        authority.callbackFunc = authorityCallBack
        pview.present(authority, animated: false)
    }
    
    public func authorityDismiss() {
        authority.dismiss(animated: false, completion: nil)
    }
    
    public func policyShow() {
        checkEstgamesData()

        policy.callbackFunc = policyCallBack
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
        checkEstgamesData()
        
        banner.show()
    }
}
