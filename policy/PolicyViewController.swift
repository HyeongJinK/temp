//
//  PolicyController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 28..
//

import UIKit

class PolicyViewController: UIViewController {
    var backgroudView:UIView!
    var titleLabel1:UILabel!
    var titleLabel2:UILabel!
    var subTitleLabel: UILabel!
    var webView1:UIWebView!
    var webView2:UIWebView!
    var submitBt1: UIButton!
    var submitBt2: UIButton!
    var closeBt: UIButton!
    
    
    func dataSet() {
        
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)

        backgroudView = UIView(frame: CGRect(x: 41.5, y: 71.5, width: 293.5, height: 522.5))
        
        //self.view.frame = CGRect(x: 41.5, y: 71.5, width: 522.5, height: 293.5)
        //self.preferredContentSize.height = 522.5
        //self.preferredContentSize.width = 293.5
        
        var backgroudImg = UIImage(named: "img_provision_bigbox", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!
        
        //backgroudView.backgroundColor = UIColor(patternImage: backgroudImg)
        backgroudView.backgroundColor = UIColor(red: 53/255, green: 59/255, blue: 72/255, alpha: 1)
    
        titleLabel1 = UILabel(frame: CGRect(x: 0 , y: 39, width: backgroudView.frame.width, height: 13))
        //titleLabel1.center.x = self.view.center.x
        titleLabel1.text = "이용약관"
        titleLabel1.textAlignment = .center
        titleLabel1.textColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        titleLabel1.font = UIFont.systemFont(ofSize: 13)
        
        subTitleLabel = UILabel(frame: CGRect(x: 0, y: 57, width: backgroudView.frame.width, height: 10))
        subTitleLabel.text = "광고성 정보 수신 동의포함"
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = UIColor(red: 1, green: 95/255, blue: 95/255, alpha: 1)
        subTitleLabel.font = UIFont.systemFont(ofSize: 10)
        
        webView1 = UIWebView(frame: CGRect(x: 26.5, y: 78, width: 240, height: 135))
        
        submitBt1 = UIButton(frame: CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5))
        submitBt1.setTitle("동의합니다", for: .normal)
        
        titleLabel2 = UILabel(frame: CGRect(x: 0, y: 287, width: backgroudView.frame.width, height: 13))
        titleLabel2.text = "개인정보 취급방침"
        titleLabel2.textAlignment = .center
        titleLabel2.textColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        titleLabel2.font = UIFont.systemFont(ofSize: 13)
        
        webView2 = UIWebView(frame: CGRect(x: 26.5, y: 311, width: 240, height: 134.5))
        
        submitBt2 = UIButton(frame: CGRect(x: 26.5, y: 454, width: 241, height: 37.5))
        submitBt2.setTitle("동의합니다", for: .normal)
        
        closeBt = UIButton(frame: CGRect(x: backgroudView.frame.width - 10.5 - 18, y: 11, width: 18, height: 18))
        let closeBtImage = UIImage(named: "btn_close_img", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!
        closeBt.setImage(closeBtImage, for: .normal)
        
        self.view.addSubview(backgroudView)
        backgroudView.addSubview(titleLabel1)
        backgroudView.addSubview(titleLabel2)
        backgroudView.addSubview(subTitleLabel)
        backgroudView.addSubview(webView1)
        backgroudView.addSubview(webView2)
        backgroudView.addSubview(submitBt1)
        backgroudView.addSubview(submitBt2)
        backgroudView.addSubview(closeBt)
    }
}
