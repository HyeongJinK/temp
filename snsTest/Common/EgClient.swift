//
//  EgClient.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 17..
//  Copyright © 2018년 estgames. All rights reserved.
//

import UIKit

@objc class EgClient : NSObject{
    let api: Api = Api()
    private var pview: UIViewController?
    var data: ResultDataJson?
    private let auth: AuthorityViewController
    private let policy: PolicyViewController
    private let webView: WebViewUIController
    private var bannerframework: BannerFramework?
    
    
    override init() {
        auth = AuthorityViewController()
        auth.modalPresentationStyle = .overCurrentContext
        policy = PolicyViewController()
        policy.modalPresentationStyle = .overCurrentContext
        webView = WebViewUIController()
        webView.modalPresentationStyle = .overCurrentContext
    }
    
    public func from(pview : UIViewController) {
        self.pview = pview
    }
    
    private func commonfunc() -> String? {
        return nil
    }
    
    public func authority(action: Action<String>) -> String? {
        guard let view = self.pview else {
            print("view 설정이 안되어 있음")
            return "fail"
        }
            
        guard data != nil else {
            api.appScript(region: MpInfo.App.region, lang: EgClient.getLang(), completion: {(str: Data?) -> Void in
                self.data = ResultDataJson(str)
            })
            while (self.data == nil) {}
            
            guard self.data?.code == nil else {
                return self.data!.message
            }
            self.auth.setAction(action: action)
            self.auth.setWebUrl(url: self.data!.url?.system_contract)
            view.present(self.auth, animated: false)
            return "sucess"
        }
        
        guard self.data?.code == nil else {
            return self.data!.message
        }
        
        view.present(self.auth, animated: false)
        return nil
    }
    
    public func policy(action: Action<String>) -> String? {
        guard let view = self.pview else {
            print("view 설정이 안되어 있음")
            return "fail"
        }
        
        guard data != nil else {
            api.appScript(region: MpInfo.App.region, lang: EgClient.getLang(), completion: {(str: Data?) -> Void in
                self.data = ResultDataJson(str)
            })
            while (self.data == nil) {}
            
            guard self.data?.code == nil else {
                return self.data!.message
            }
            self.policy.setAction(action: action)
            self.policy.setWebUrl(webUrl1: self.data!.url?.contract_service, webUrl2: self.data!.url?.contract_private)
            view.present(self.policy, animated: false)
            return "sucess"
        }
        
        guard self.data?.code == nil else {
            return self.data!.message
        }
        
        view.present(self.policy, animated: false)
        return nil
    }
    
    public func banner(action: Action<String>) -> String? {
        guard let view = self.pview else {
            print("view 설정이 안되어 있음")
            return "fail"
        }
        
        guard data != nil else {
            api.appScript(region: MpInfo.App.region, lang: EgClient.getLang(), completion: {(str: Data?) -> Void in
                self.data = ResultDataJson(str)
            })
            while (self.data == nil) {}
            
            guard self.data?.code == nil else {
                return self.data!.message
            }
            self.bannerframework = BannerFramework(pview: view, result: self.data!)
            self.bannerframework!.setAction(action: action)
            self.bannerframework!.show()
            
            return "sucess"
        }
        
        guard self.data?.code == nil else {
            return self.data!.message
        }
        
        guard let bannerframework = bannerframework else {
            self.bannerframework = BannerFramework(pview: view, result: self.data!)
            self.bannerframework!.setAction(action: action)
            self.bannerframework!.show()
            return nil
        }
        bannerframework.setAction(action: action)
        bannerframework.show()
        return nil
    }
    
    

    public func cs(action: Action<String>) -> String? {
        guard let view = self.pview else {
            print("view 설정이 안되어 있음")
            return "fail"
        }
        
        guard let data = data else {
            api.appScript(region: MpInfo.App.region, lang: EgClient.getLang(), completion: {(str: Data?) -> Void in
                self.data = ResultDataJson(str)
            })
            while (self.data == nil) {}
            
            guard self.data?.code == nil else {
                return self.data!.message
            }
            webView.egToken = MpInfo.Account.egToken
            webView.nation = getNation()
            webView.url = self.data!.url?.cscenter
            view.present(webView, animated: false)
            
            return "sucess"
        }
        webView.egToken = MpInfo.Account.egToken
        webView.nation = getNation()
        webView.url = data.url?.cscenter
        view.present(webView, animated: false)
        return nil
    }

    public func notice() -> String? {
        return nil
    }

    public func event() -> String? {
        return nil
    }
    
    public func getNation() -> String {
        guard let data = data else {return ""}
        
        return data.nation
    }
    
    static func getLang() -> String {
        guard let lang = UserDefaults.standard.string(forKey: "i18n_language") else {
            guard let defaultLang = Locale.current.languageCode else {
                return  "ko"
            }
            return defaultLang
        }
        
        return lang
    }
    
//    public func getLocale() -> String {
//        return ""
//    }
 }
