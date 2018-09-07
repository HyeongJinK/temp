//
//  ApiCallController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 26..
//

import Foundation
import Alamofire


extension String {
    func localized() ->String {
        let defaultLang = UserDefaults.standard.string(forKey: "i18n_language")
        let lang:String?
        
        if (defaultLang == nil) {
            lang = Locale.current.languageCode
        } else {
            lang = defaultLang
        }
        
        let bundle:Bundle? = Bundle(identifier: "org.cocoapods.estgames-common-framework")
        var path = bundle?.path(forResource: lang, ofType: "lproj")//Bundle.main.path(forResource: lang, ofType: "lproj")
        
        if path == nil {
            path = bundle?.path(forResource: "en", ofType: "lproj")
        }
        
        if let p = path {
            let b = Bundle(path: p)
            if let d = b {
                return NSLocalizedString(self, tableName: nil, bundle: d, value: "", comment: "")
            } else {
                return NSLocalizedString(self, comment: "");
            }
        } else {
            return NSLocalizedString(self, comment: "");
        }
        
    }
}

@objc public class EstgamesCommon : NSObject {
    var apiCallCount = 0;
    var processIndex : Int = 0
    let pview: UIViewController
    static var estgamesData: ResultDataJson?
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
        //let url = MpInfo.App.estapi+"/sd_v_1_" + MpInfo.App.env + "?region=" + MpInfo.App.region + "&lang="+getLanguage()!
        let url = MpInfo.App.estapi+"/sd_v_1_live?region=" + MpInfo.App.region + "&lang="+getLanguage()!
        apiCallCount += 1
        
        if (apiCallCount >= 3) {    //api 호출 실패가 3번이 넘으면
            apiCallCount = 0
            self.estCommonFailCallBack(Fail.START_API_NOT_CALL)
            return
        }
        
        URLCache.shared.removeAllCachedResponses()
        //let semaphore = DispatchSemaphore(value : 0)
        //queue.async {
            request(url)
                .validate(contentType: ["application/json"])
                .validate(statusCode: 200..<400)
                .responseJSON() {
                    response in
                    if (response.result.isSuccess) {
                        if let result = response.result.value {
                            let bannerJson = result as! NSDictionary
                            if ((bannerJson["errorMessage"] as? String) != nil){    //3번 에러가 났을 경우 한번 더 시도
                                self.create()
                            } else {
                                EstgamesCommon.estgamesData = ResultDataJson(resultDataJson:bannerJson as! NSDictionary)   //배너 파싱
                                self.authority.setWebUrl(url: EstgamesCommon.estgamesData!.url.system_contract)
                                self.banner = bannerFramework(pview: self.pview, result: EstgamesCommon.estgamesData!)
                                self.policy.setWebUrl(webUrl1: EstgamesCommon.estgamesData!.url.contract_service, webUrl2: EstgamesCommon.estgamesData!.url.contract_private)
                                self.process = EstgamesCommon.estgamesData!.process
                                self.initCallBack(self)
                            }
                            //myGroup.leave()
                            //semaphore.signal()
                        } else {
                            self.estCommonFailCallBack(Fail.START_API_DATA_FAIL)
                        }
                    } else {
                        self.estCommonFailCallBack(Fail.START_API_NOT_CALL)
                    }
            }
        //semaphore.wait()
        //semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
    private func checkEstgamesData() -> Bool{
        if EstgamesCommon.estgamesData == nil {
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
            if (processIndex != -1 && process[processIndex] == "use_contract" && policy.isShowPolicyShow()) {
                estCommonFailCallBack(Fail.PROCESS_DENIED_CONTRACT)
            } else {
                call()
            }
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
            webView.nation = getLanguage()!
            webView.url = EstgamesCommon.estgamesData!.url.cscenter
            
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
            webView.nation = getLanguage()!
            webView.url = EstgamesCommon.estgamesData!.url.notice
            //webView.url = "https://m-stage.estgames.co.kr/cs/mr"
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
            webView.nation = getLanguage()!
            webView.url = EstgamesCommon.estgamesData!.url.event
            
            pview.present(webView, animated: false)
        }
    }
    
    public func showCommonWebView(url: String) {
        webView = WebViewUIController()
        webView.egToken = MpInfo.Account.egToken
        webView.modalPresentationStyle = .overCurrentContext
        webView.nation = getLanguage()!
        webView.url = url
        
        pview.present(webView, animated: false)
    }
    
    public func getNation() -> String? {
        if (!checkEstgamesData()) {
            self.estCommonFailCallBack(Fail.START_API_DATA_INIT)
            return "";
        } else {
            if let data = EstgamesCommon.estgamesData {
                return data.nation
            }
            return ""
        }
    }
    
    public func getLanguage() -> String? {
        if let lang = UserDefaults.standard.string(forKey: "i18n_language") {
            return lang
        }
        
        if let lang = Locale.current.languageCode {
            return lang
        }
        return "ko"
    }
    
    static func getOpenUrl() ->String {
        if (EstgamesCommon.estgamesData == nil) {
            return ""
        } else {
            return estgamesData!.url.game_open;
        }
    }
    
    public func setLanguage(lang: String) {
        UserDefaults.standard.set (lang, forKey : "i18n_language")
        UserDefaults.standard.synchronize ()
    }
}
