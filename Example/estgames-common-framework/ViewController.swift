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
    var estgamesCommon:EstgamesCommon!
    var userDialog: UserDialog!
    
    var vc : UserService!
    
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
        estgamesCommon = EstgamesCommon(pview: self)
        userDialog = UserDialog(pview: self)
        userDialog.setUserLinkAction(closeAction: {() -> Void in print("closeAction")}, confirmAction: {() -> Void in print("confirmAction")}, cancelAction: {() -> Void in print("cancelAction")})
        userDialog.setUserLinkCharacterLabel(guest: "adfads", sns: "bzcxvczxv")
        userDialog.setUserGuestLinkCharacterLabel(guest: "fjkd", sns: "fjkjf")
        dataPrint()
    }
    
    @IBAction func rePrint(_ sender: Any) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func processAction(_ sender: Any) {
        estgamesCommon.processShow()
    }
    
    @IBAction func bannerTest(_ sender: Any) {
        estgamesCommon.bannerShow()
    }
    
    func authCallBack() {
        print("authority Call Back")
    }
    
    @IBAction func authorityTest(_ sender: Any) {
        estgamesCommon.authorityCallBack = authCallBack
        estgamesCommon.authorityShow()
    }
    
    
    @IBAction func policyTest(_ sender: Any) {
        estgamesCommon.policyCallBack = {() -> Void in
            var ttt:Bool = self.estgamesCommon.contractPrivate()
            self.estgamesCommon.contractService()
            print(ttt)
            }
        estgamesCommon.policyShow()
    }
    
    @IBAction func testttt(_ sender: Any) {
        con1.text = estgamesCommon.contractService().description
        con2.text = estgamesCommon.contractPrivate().description
        //print(userDialog.getInputText())
    }
    
    /**
     계정연동 UI만 띄우기
     */
    @IBAction func userLinkTest(_ sender: Any) {
        userDialog.showUserLinkDialog()
    }
    
    @IBAction func UserLoadTest(_ sender: Any) {
        userDialog.showUserLoadDialog()
    }
    
    @IBAction func UserGuestLinkTest(_ sender: Any) {
        userDialog.showUserGuestLinkDialog()
    }
    
    @IBAction func UserResultTest(_ sender: Any) {
        userDialog.showUserResultDialog()
    }
    
    /**
     계정연동 부분
     ***/
    let accountService = AccountService()
    
    
    @IBAction func crateToken(_ sender: Any) {
        vc.startGame()
    }
    
    @IBAction func clearToken(_ sender: Any) {
        vc.clearKey()
    }
    
    @IBAction func snsConnect(_ sender: Any) {
        vc.goToLogin()
    }
}

