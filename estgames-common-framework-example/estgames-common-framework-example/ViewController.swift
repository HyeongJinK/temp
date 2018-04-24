//
//  ViewController.swift
//  estgames-common-framework
//
//  Created by wkzkfmxk23@gmail.com on 02/07/2018.
//  Copyright (c) 2018 wkzkfmxk23@gmail.com. All rights reserved.
//

import UIKit
import estgames_common_framework

class ViewController: UIViewController {
    var dashboard: WebViewDialog!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        vc = UserService(pview: self)
        dashboard = WebViewDialog(pview: self, egToken: MpInfo.Account.egToken)
        estgamesCommon = EstgamesCommon(pview: self)
        userDialog = UserDialog(pview: self)
        userDialog.setUserLinkAction(closeAction: {() -> Void in print("closeAction")}, confirmAction: {() -> Void in print("confirmAction")}, cancelAction: {() -> Void in print("cancelAction")})
        userDialog.setUserLinkCharacterLabel(guest: "adfads", sns: "bzcxvczxv")
        userDialog.setUserGuestLinkCharacterLabel(guest: "fjkd", sns: "fjkjf")
        dataPrint()
    }
    func dataPrint() {
        self.lblIdentityId.text = vc.getPrincipal()
        self.lblPrincipal.text = MpInfo.Account.principal
        self.lblProviderName.text = MpInfo.Account.provider
        self.lblEgId.text = MpInfo.Account.egId
        self.lblEgToken.text = MpInfo.Account.egToken
        self.lblRefreshToken.text = MpInfo.Account.refreshToken
        self.lblEmail.text = String(describing:MpInfo.Account.email)
    }
    
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
    //    /**
    //     계정연동 부분
    //     ***/
    //    let accountService = AccountService()
    //
    //
    //    @IBAction func crateToken(_ sender: Any) {
    //        vc.startGame()
    //    }
    //
    //    @IBAction func clearToken(_ sender: Any) {
    //        vc.clearKey()
    //    }
    //
    //    @IBAction func snsConnect(_ sender: Any) {
    //        vc.goToLogin()
    //    }
    //    @IBAction func rePrint(_ sender: Any) {
//        dataPrint()
//    }
//    func dataPrint() {
//        self.lblIdentityId.text = vc.getPrincipal()
//        self.lblPrincipal.text = MpInfo.Account.principal
//        self.lblProviderName.text = MpInfo.Account.provider
//        self.lblEgId.text = MpInfo.Account.egId
//        self.lblEgToken.text = MpInfo.Account.egToken
//        self.lblRefreshToken.text = MpInfo.Account.refreshToken
//        self.lblEmail.text = String(describing:MpInfo.Account.email)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    // 순서대로 호출
//    @IBAction func processAction(_ sender: Any) {
//        estgamesCommon.processCallBack = {() -> Void in //순서대로 호출이 끝나고 호출하는 콜백함수
//            print(self.estgamesCommon.contractService().description)
//            print(self.estgamesCommon.contractPrivate().description)
//            }
//        estgamesCommon.processShow()
//    }
//    // 배너만 따로 호출
//    @IBAction func bannerTest(_ sender: Any) {
//        estgamesCommon.bannerShow()
//    }
//
//    func authCallBack() {
//        print("authority Call Back")
//    }
//    // 권한만 따로 호출
//    @IBAction func authorityTest(_ sender: Any) {
//        estgamesCommon.authorityCallBack = authCallBack
//        estgamesCommon.authorityShow()
//    }
//
//    // 이용약관만 따로 호출
//    @IBAction func policyTest(_ sender: Any) {
//        estgamesCommon.policyCallBack = {() -> Void in
//            print(self.estgamesCommon.contractService())
//            print(self.estgamesCommon.contractPrivate())
//            }
//        estgamesCommon.policyShow()
//    }
//
//    @IBAction func testttt(_ sender: Any) {
//        con1.text = estgamesCommon.contractService().description
//        con2.text = estgamesCommon.contractPrivate().description
//        //print(userDialog.getInputText())
//    }
//
//    /**
//     계정연동 UI만 띄우기
//     */
//    @IBAction func userLinkTest(_ sender: Any) {
//        userDialog.showUserLinkDialog()
//    }
//
//    @IBAction func UserLoadTest(_ sender: Any) {
//        userDialog.showUserLoadDialog()
//    }
//
//    @IBAction func UserGuestLinkTest(_ sender: Any) {
//        userDialog.showUserGuestLinkDialog()
//    }
//
//    @IBAction func UserResultTest(_ sender: Any) {
//        userDialog.showUserResultDialog()
//    }
//
//    /**
//     웹뷰창
//     */
//    @IBAction func webViewShowTest(_ sender: Any) {
//        dashboard.show()
//    }
//
//

}

