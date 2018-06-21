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
    public var initCallBack: (EstgamesCommon) -> Void = {(uv: EstgamesCommon) -> Void in}
    public var estCommonFailCallBack: (Fail) -> Void = {(error: Fail) -> Void in}
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
        //dataSet(pview: pview)
    }
    
    public init(pview:UIViewController, initCallBack: @escaping (EstgamesCommon) -> Void) {
        self.pview = pview
        self.initCallBack = initCallBack
        authority = AuthorityViewController()
        authority.modalPresentationStyle = .overCurrentContext
        
        policy = PolicyViewController()
        policy.modalPresentationStyle = .overCurrentContext
        super.init()
    //    dataSet(pview: pview)
    }
    
    public func create() {
        if estgamesData == nil {
            //let url = MpInfo.App.estapi+"/sd_v_1_" + MpInfo.App.env + "?region=" + MpInfo.App.region + "&lang="+getLanguage()!
            let url = MpInfo.App.estapi+"/sd_v_1_live?region=" + MpInfo.App.region + "&lang="+getLanguage()!
            apiCallCount += 1
            
            if (apiCallCount >= 3) {    //api 호출 실패가 3번이 넘으면
                apiCallCount = 0
                self.estCommonFailCallBack(Fail.START_API_NOT_CALL)
                return
            }
            
            
            URLCache.shared.removeAllCachedResponses()
            //queue.async {
                request(url)
                    .validate(contentType: ["application/json"])
                    .validate(statusCode: 200..<300)
                    .responseJSON() {
                        response in
                        if (response.result.isSuccess) {
                            if let result = response.result.value {
                                let bannerJson = result as! NSDictionary
                                if ((bannerJson["errorMessage"] as? String) != nil){    //3번 에러가 났을 경우 한번 더 시도
                                    self.create()
                                } else {
                                    self.estgamesData = ResultDataJson(resultDataJson:bannerJson as! NSDictionary)   //배너 파싱
                                    self.authority.setWebUrl(url: self.estgamesData!.url.system_contract)
                                    self.banner = bannerFramework(pview: self.pview, result: self.estgamesData!)
                                    self.policy.setWebUrl(webUrl1: self.estgamesData!.url.contract_service, webUrl2: self.estgamesData!.url.contract_private)
                                    self.process = self.estgamesData!.process
                                    self.initCallBack(self)
                                }
                                //myGroup.leave()
                            } else {
                                self.estCommonFailCallBack(Fail.START_API_DATA_FAIL)
                            }
                        } else {
                            self.estCommonFailCallBack(Fail.START_API_NOT_CALL)
                        }
                }
            //}
        }
    }
    
    private func checkEstgamesData() -> Bool{
        if estgamesData == nil {
            return false
        }
        return true;
    }
    
    
    /**
     공개 함수 api에 있는 순서대로 호출
     */
    public func processShow() {
        if (!checkEstgamesData()) {
            //에러 코드 리턴
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
        } else {
            processIndex = -1
            check()
        }
    }
    
    func check() {
        if ((process.count-1) > processIndex) {
            call()
        } else {
            processCallBack()
        }
    }
    
    func call() {
        processIndex += 1
        switch self.process[processIndex] {
            case "banner":
                if (banner.count() > 0) {
                    banner.closeBtCallBack = check
                    banner.show()
                } else {
                    check()
                }
            break
            case "system_contract":
                check()
//                authority.callbackFunc = check
//                pview.present(authority, animated: false)
                break
            case "use_contract" :
                if (policy.isShowPolicyShow()) {
                    policy.callbackFunc = check
                    pview.present(policy, animated: false)
                } else {
                    check()
                }
                break
            //case "login" :
            default:
                check()
                break
        }
    }
    
    /**
     공개 함수 각각 호출
     */
    
    //권한
    public func authorityShow() {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
        } else {
            authority.callbackFunc = authorityCallBack
            pview.present(authority, animated: false)
        }
    }
    
    public func authorityDismiss() {
        authority.dismiss(animated: false, completion: nil)
    }
    
    //이용약관
    public func policyShow() {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
        } else {
            if (policy.isShowPolicyShow()) {
                policy.callbackFunc = policyCallBack
                //policy.closeBt.closeBtActionCallBack = policyCallBack
                pview.present(policy, animated: false)
            }
        }
    }
    
    public func policyDismiss() {
        policy.dismiss(animated: false, completion: nil)
    }
    //이용약관 동의합니다. 버튼 체크했는 지 확인 버튼
    public func contractService() -> Bool {
        if (!policy.isShowPolicyShow()) {   //이전에 이용약관 동의를 한 상태
            return true
        }
        
        return policy.submitBt1.isChecked
    }
    
    public func contractPrivate() -> Bool {
        if (!policy.isShowPolicyShow()) {   //이전에 이용약관 동의를 한 상태
            return true
        }
        
        return policy.submitBt2.isChecked
    }
    //배너
    public func bannerShow() {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
        } else {
            banner.closeBtCallBack = bannerCallBack
            banner.show()
        }
    }
    
    public func showCsCenter() {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
        } else {
            webView = WebViewUIController()
            webView.egToken = MpInfo.Account.egToken
            webView.modalPresentationStyle = .overCurrentContext
            webView.nation = self.estgamesData!.language
            webView.url = self.estgamesData!.url.cscenter
            
            pview.present(webView, animated: false)
        }
    }
    
    //이용약관 다이얼로그
    public func showNotice() {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
            return;
        } else {
            webView = WebViewUIController()
            webView.egToken = MpInfo.Account.egToken
            webView.modalPresentationStyle = .overCurrentContext
            webView.nation = self.estgamesData!.language
            webView.url = self.estgamesData!.url.notice
            
            pview.present(webView, animated: false)
        }
    }
    public func showEvent() {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
            return;
        } else {
            webView = WebViewUIController()
            webView.egToken = MpInfo.Account.egToken
            webView.modalPresentationStyle = .overCurrentContext
            webView.nation = self.estgamesData!.language
            webView.url = self.estgamesData!.url.event
            
            pview.present(webView, animated: false)
        }
    }
    
    public func getNation() -> String? {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
            return "";
        } else {
            if let data = estgamesData {
                return data.nation
            }
            return ""
        }
    }
    
    public func getLanguage() -> String? {
        if let lang = Locale.current.languageCode {
            return lang;
        }
        return "KO"
    }
}
