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

class ViewController: UIViewController {
    var estgamesCommon:EstgamesCommon!
    var vc : UserService!
    
    var userDialog: UserDialog!
    
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
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        
        estgamesCommon = EstgamesCommon(pview: self)    // EstgamesCommon 객체 생성
        estgamesCommon.initCallBack = {(estcommon) -> Void in   //EstgamesCommon에 create 함수를 호출 하고 값 설정이 성공했을 때 호출 되는 함수
            self.errorCode.text = "성공"
        }
        estgamesCommon.estCommonFailCallBack = {(err) -> Void in    //EstgamesCommon 내에서 에러가 발생 했을 경우 호출되는 콜백함수
            switch (err) {
                case .START_API_NOT_CALL :
                    self.errorCode.text = "API 호출 시 네트워크 에러"
                    break
                case .START_API_DATA_FAIL :
                    self.errorCode.text = "내려 받은 값 오류"
                    break
                case .START_API_DATA_INIT :
                    self.errorCode.text = "값이 초기화 되지 않았습니다."
                    break
                default:
                break
            }
        }
        estgamesCommon.create();    //스타트 api 호출, 내려받은 값으로 설정
        
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
        
        vc.goToLoginSuccessCallBack = {(egId, resultType) -> Void in
            print("goToLogin() 함수 호출 성공 시 호출되는 콜백함수")
            print(egId)
            print(resultType)
        }
        
        vc.goToLoginCloseCallBack = {() -> Void in
            print("goToLogin() 도중 중간에 끝냄")
        }
        
        vc.failCallBack = {(err) -> Void in     //유저 서비스 부분 에러 콜백 함수
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
        vc.goToLogin()
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
        estgamesCommon.showNotice()
    }
    
    @IBAction func faqTest(_ sender: Any) {
        estgamesCommon.showCsCenter()
    }
}

