//
//  ApiCallController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation
import Alamofire

@objc public class EstgamesCommon : NSObject {
    var apiCallCount = 0;
    var processIndex : Int = 0
    let pview: UIViewController
    var estgamesData: ResultDataJson?
    var banner:bannerFramework!
    let authority: AuthorityViewController
    public var authorityCallBack : () -> Void = { () -> Void in}
    public var policyCallBack : () -> Void = { () -> Void in}
    public var bannerCallBack : () -> Void = { () -> Void in}
    public var processCallBack : () -> Void = { () -> Void in}
    public var initCallBack: (UIViewController) -> Void = {(uv: UIViewController) -> Void in}
    let policy: PolicyViewController
    var process: [String] = Array<String>()
    
    
    var webView: WebViewUIController!
    
    
    public init(pview:UIViewController) {
        self.pview = pview
        
        authority = AuthorityViewController()
        authority.modalPresentationStyle = .overCurrentContext
        
        policy = PolicyViewController()
        policy.modalPresentationStyle = .overCurrentContext
        super.init()
        dataSet(pview: pview)
    }
    
    private func dataSet(pview:UIViewController) {
        if estgamesData == nil {
            let myGroup = DispatchGroup.init()
            let queue = DispatchQueue.global()
            let url = MpInfo.App.estapi.replacingOccurrences(of: "env", with: MpInfo.App.env)
            
            
            //let manager = SessionManager.default
            //manager.session.configuration.timeoutIntervalForRequest = 10
            myGroup.enter()
            apiCallCount += 1
            
            if (apiCallCount >= 3) {    //api 호출 실패가 3번이 넘으면
                myGroup.leave()
                return
            }
            queue.async {
                request(url)
                    .validate(contentType: ["application/json"])
                    .validate(statusCode: 200..<300)
                    .responseJSON() {
                        response in
                        if let result = response.result.value {
                            let bannerJson = result as! NSDictionary
                            if ((bannerJson["errorMessage"] as? String) != nil){
                                self.dataSet(pview: pview)
                            } else {
                                self.estgamesData = ResultDataJson(resultDataJson:bannerJson[MpInfo.App.region] as! NSDictionary)   //배너 파싱
                                self.authority.setWebUrl(url: self.estgamesData!.url.system_contract)
                                self.banner = bannerFramework(pview: pview, result: self.estgamesData!)
                                self.policy.setWebUrl(webUrl1: self.estgamesData!.url.contract_service, webUrl2: self.estgamesData!.url.contract_private)
                                self.process = self.estgamesData!.process[self.estgamesData!.nation.lowercased()] as! Array<String>
                                self.initCallBack(self.pview)
                            }
                            myGroup.leave()
                        } else {
                            print("error")
                        }
                }
            }
        }
    }
    
    private func checkEstgamesData() -> Bool{
        if estgamesData == nil {
            dataSet(pview: self.pview)
            return false
        }
        return true;
    }
    
    
    /**
     공개 함수 api에 있는 순서대로 호출
     */
    public func processShow() {
        checkEstgamesData()
        check()
    }
    
    func check() {
        if (process.count > processIndex) {
            call()
        } else {
            processIndex = 0
            processCallBack()
        }
    }
    
    func call() {
        switch self.process[processIndex] {
            case "event":
                processIndex += 1
                banner.closeBtCallBack = check
                banner.show()
            break
            case "system_contract":
                processIndex += 1
                authority.callbackFunc = check
                pview.present(authority, animated: false)
                break
            case "use_contract" :
                processIndex += 1
                policy.callbackFunc = check
                pview.present(policy, animated: false)
                break
            //case "login" :
            default:
                processIndex += 1
                check()
                break
        }
    }
    
    /**
     공개 함수 각각 호출
     */
    
    //권한
    public func authorityShow() {
        checkEstgamesData()
        
        authority.callbackFunc = authorityCallBack
        pview.present(authority, animated: false)
    }
    
    public func authorityDismiss() {
        authority.dismiss(animated: false, completion: nil)
    }
    
    //이용약관
    public func policyShow() {
        if (!checkEstgamesData()) {
            return;
        }

        policy.callbackFunc = policyCallBack
        pview.present(policy, animated: false)
    }
    
    public func policyDismiss() {
        policy.dismiss(animated: false, completion: nil)
    }
    //이용약관 동의합니다. 버튼 체크했는 지 확인 버튼
    public func contractService() -> Bool {
        return policy.submitBt1.isChecked
    }
    
    public func contractPrivate() -> Bool {
        return policy.submitBt2.isChecked
    }
    //배너
    public func bannerShow() {
        checkEstgamesData()
        
        banner.closeBtCallBack = bannerCallBack
        banner.show()
    }
    
    public func showCsCenter() {
        webView = WebViewUIController()
        webView.egToken = MpInfo.Account.egToken
        webView.modalPresentationStyle = .overCurrentContext
        webView.nation = self.estgamesData!.language
        webView.url = "https://m-stage.estgames.co.kr/cs/mr/dashboard"
        pview.present(webView, animated: false)
    }
    
    //이용약관 다이얼로그
    public func showNotice() {
        webView = WebViewUIController()
        webView.egToken = MpInfo.Account.egToken
        webView.modalPresentationStyle = .overCurrentContext
        webView.nation = self.estgamesData!.language
        webView.url = "https://m-stage.estgames.co.kr/cs/"+MpInfo.App.appId+"/notices"
        pview.present(webView, animated: false)
    }
}
