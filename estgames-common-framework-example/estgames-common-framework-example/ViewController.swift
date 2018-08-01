//
//  ViewController.swift
//  estgames-common-framework
//
//  Created by wkzkfmxk23@gmail.com on 02/07/2018.
//  Copyright (c) 2018 wkzkfmxk23@gmail.com. All rights reserved.
//

import UIKit
import estgames_common_framework
import GoogleSignIn

import AWSAuthUI
import AWSFacebookSignIn
import AWSGoogleSignIn
import SwiftKeychainWrapper

class ViewController: UIViewController {
    var estgamesCommon:EstgamesCommon!
    var vc : UserService!
    var gameAgent: GameAgent = GameAgent()
    
    var userDialog: UserDialog!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet var lblIdentityId: UILabel!
    @IBOutlet var lblPrincipal: UILabel!
    @IBOutlet var lblProviderName: UILabel!
    @IBOutlet var lblEgId: UILabel!
    @IBOutlet var lblEgToken: UILabel!
    @IBOutlet var lblRefreshToken: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    @IBOutlet var con1: UILabel!
    @IBOutlet var con2: UILabel!
    
    @IBOutlet var nation: UILabel!
    @IBOutlet var lang: UILabel!
    @IBOutlet var callBack: UILabel!
    @IBOutlet var errorCode: UILabel!
    
    @IBAction func noticeAction(_ sender: Any) {
        estgamesCommon.showNotice()
    }
    
    @IBAction func faqAction(_ sender: Any) {
        estgamesCommon.showCsCenter()
    }
    @IBOutlet var faqAction: UIButton!
    
    
    override func viewDidLoad() {
        MpInfo.App.region = "mr.global.ls"
        super.viewDidLoad()
        
        //KeychainWrapper.standard.string(forKey: <#T##String#>)
        
//        let image:UIImage
//        let imageView:UIImageView
//        
//        imageView.contentMode = .scaleToFill
        
        self.navigationController?.isNavigationBarHidden = true
        
        estgamesCommon = EstgamesCommon(pview: self)    // EstgamesCommon 객체 생성
        estgamesCommon.initCallBack = {(estcommon) -> Void in   //EstgamesCommon에 create 함수를 호출 하고 값 설정이 성공했을 때 호출 되는 함수
            print("성공")
            self.errorCode.text = "성공"
        }
        estgamesCommon.estCommonFailCallBack = {(err) -> Void in    //EstgamesCommon 내에서 에러가 발생 했을 경우 호출되는 콜백함수
            switch (err) {
                case .START_API_NOT_CALL :
                    self.callBack.text = "API 호출 시 네트워크 에러"
                    break
                case .START_API_DATA_FAIL :
                    self.callBack.text = "내려 받은 값 오류"
                    break
                case .START_API_DATA_INIT :
                    self.callBack.text = "값이 초기화 되지 않았습니다."
                    break
                case .PROCESS_DENIED_CONTRACT :
                    self.callBack.text = "이용약관을 동의해주세요"
                break
                default:
                break
            }
        }
        //estgamesCommon.setLanguage(lang: "ko")
        estgamesCommon.create();    //스타트 api 호출, 내려받은 값으로 설정
        //MpInfo.App.region = "test"
        estgamesCommon.processCallBack = {() -> Void in //processShow() 호출이 끝나고 호출하는 콜백함수
            self.callBack.text = "processShow 종료"
            self.con1.text = self.estgamesCommon.contractService().description
            self.con2.text = self.estgamesCommon.contractPrivate().description
        }

        estgamesCommon.bannerCallBack = {() -> Void in //bannerShow() 함수 호출 이후 호출되는 콜백함수
            self.callBack.text = "bannerShow() 종료"
        }
        
        estgamesCommon.authorityCallBack = {() -> Void in //authorityShow() 함수 호출 이후 호출되는 콜백함수
            self.callBack.text = "authorityShow() 종료"
        }
        
        estgamesCommon.policyCallBack  = {() -> Void in //policyShow() 함수 호출 이후 호출되는 콜백함수
            self.callBack.text = "policyShow() 종료"
            self.con1.text = self.estgamesCommon.contractService().description
            self.con2.text = self.estgamesCommon.contractPrivate().description
        }
        
        
        
        vc = UserService(pview: self, googleEmail: googleEmail)
    
        vc.startSuccessCallBack = {() -> Void in
            print("startGame() 함수 호출 성공 시 호출되는 콜백함수")
        }
        
        vc.goToLoginSuccessCallBack = {(egId, resultType, pro) -> Void in            
            print("goToLogin() 함수 호출 성공 시 호출되는 콜백함수")
            self.callBack.text = "goToLogin() 함수 호출 성공 시 호출되는 콜백함수"
        }
        
        vc.goToLoginFailCallBack = {(fail) -> Void in
            self.callBack.text = fail.describe
        }
        
        vc.goToLoginCloseCallBack = {() -> Void in
            print("goToLogin() 도중 중간에 끝냄")
        }
        
        vc.failCallBack = {(err) -> Void in     //유저 서비스 부분 에러 콜백 함수
            print(err.describe)
            switch (err) {
                case .TOKEN_EMPTY :
                    self.errorCode.text = "토큰이 없음"
                    break
                default:
                    break
            }
        }
        dataPrint()

    }
    
    func googleEmail() -> String {
        if let user = GIDSignIn.sharedInstance().currentUser {
            return user.profile.email
        } else {
            return ""
        }
    }
    
    func dataPrint() {
        self.lblIdentityId.text = vc.getPrincipal()
        self.lblPrincipal.text = MpInfo.Account.principal
        self.lblProviderName.text = MpInfo.Account.provider
        self.lblEgId.text = MpInfo.Account.egId
        self.lblEgToken.text = MpInfo.Account.egToken
        self.lblRefreshToken.text = MpInfo.Account.refreshToken
//        var nation:String = "";
//        if let nation2 = estgamesCommon.getNation() {nation = nation2}
        self.lblEmail.text = String(describing:MpInfo.Account.email)
    }
    
    /**
     계정연동
     */
    @IBAction func rePrint(_ sender: Any) {
        dataPrint()
    }
    
    @IBAction func gameStart(_ sender: Any) {
        vc.startGame()
    }

    @IBAction func clearToken(_ sender: Any) {
        vc.clearKey()
    }
    
    @IBAction func snsConnect(_ sender: Any) {
        let config = AWSAuthUIConfiguration()
        
        config.enableUserPoolsUI = false    //유저정보 저장 설정
        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        config.addSignInButtonView(class: AWSFacebookSignInButton.self) // 버튼 설정
        config.canCancel = true     //취소 버튼
        config.isBackgroundColorFullScreen = true    //배경색을 로고부분에만 적용할 건지 전체화면에 적용할 건지 선택
        config.backgroundColor = UIColor.black   //배경색 설정
        //config.logoImage = UIImage(named: "logo-aws")      //로고 이미지 설정
        
        vc.goToLogin(config: config)
        //vc.goToLogin()
    }
    
    
    /**
     estcommon
     */
    @IBAction func processAction(_ sender: Any) {
        estgamesCommon.processCallBack = {() -> Void in //순서대로 호출이 끝나고 호출하는 콜백함수
            self.callBack.text = "순서대로 종료"
            self.con1.text = self.estgamesCommon.contractService().description
            self.con2.text = self.estgamesCommon.contractPrivate().description
        }
        estgamesCommon.processShow()
    }
    
    @IBAction func bannerTest(_ sender: Any) {

//        var gs:GameService = GameService()
//        gs.getCharacterInfo(region: MpInfo.App.region, egId: MpInfo.Account.egId);
    
        estgamesCommon.bannerShow()
        //estgamesCommon.create()
    }
    
    
    
    @IBAction func authTest(_ sender: Any) {
        estgamesCommon.authorityShow()
    }
    
    @IBAction func policyTest(_ sender: Any) {        
        estgamesCommon.policyShow()
    }
    
    @IBAction func policyDataTest(_ sender: Any) {
        self.con1.text = self.estgamesCommon.contractService().description
        self.con2.text = self.estgamesCommon.contractPrivate().description
    }
    
    @IBAction func dashboardTest(_ sender: Any) {
        self.nation.text = estgamesCommon.getNation()
        self.lang.text = estgamesCommon.getLanguage()
    }
    
    @IBAction func noticeTest(_ sender: Any) {
        print(Fail.START_API_NOT_CALL.describe)
        //estgamesCommon.showNotice()
    }
    
    @IBAction func faqTest(_ sender: Any) {
        estgamesCommon.create()
        print("create")
    }
    @IBAction func eventTeset(_ sender: Any) {
         estgamesCommon.showEvent()
    }
    @IBAction func engTest(_ sender: Any) {
        estgamesCommon.setLanguage(lang: "fr")
    }
    @IBAction func korTest(_ sender: Any) {
        estgamesCommon.setLanguage(lang: "ko")
    }
    @IBAction func openTest(_ sender: Any) {
        gameAgent.retrieveStatus(onReceived: {(result) -> Void in
            self.errorCode.text = result.description
        }, onFail: {(fail) -> Void in
            self.errorCode.text = "점검API에러"
        })
    }
}

