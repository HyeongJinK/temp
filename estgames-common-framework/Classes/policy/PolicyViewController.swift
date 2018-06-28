//
//  PolicyController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 28..
//

import Foundation

class PolicyViewController: UIViewController {
    let policyUserDefaultName : String = "estPolicy"
    var backgroudView:UIView!
    var backImageView:UIImageView!
    var titleLabel1:UILabel!
    var titleLabel2:UILabel!
    var subTitleLabel: UILabel!
    var webView1:UIWebView!
    var webView2:UIWebView!
    var webUrl1:String?  = nil
    var webUrl2: String?  = nil
    var submitBt1: PolicyButton!
    var submitBt2: PolicyButton!
    var closeBt: PolicyCloseBt!
    var dataSet: PolicyDataSet!
    var callbackFunc:() -> Void = {() -> Void in}
    
    public func setWebUrl (webUrl1: String?, webUrl2: String?) {
        self.webUrl1 = webUrl1
        self.webUrl2 = webUrl2
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func labelSet(_ label:UILabel, _ text:String, _ color:UIColor, _ size:CGFloat) {
        label.text = text
        label.textAlignment = .center
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)//UIFont.init(name: "SpoqaHanSans", size: size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelSet(titleLabel1, "estcommon_policy_title".localized(), UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1), 13)
        
        
        labelSet(subTitleLabel, "estcommon_policy_subTitle".localized(), UIColor(red: 1, green: 95/255, blue: 95/255, alpha: 1), 10)
        
        labelSet(titleLabel2, "estcommon_policy_privacy".localized(), UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1), 13)
        
        submitBt1.setTitle("estcommon_policy_buttonText".localized(), for: .normal)
        submitBt2.setTitle("estcommon_policy_buttonText".localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        dataSet = PolicyDataSet(deviceNum: DeviceClassification.deviceResolution(self.view.frame.width, self.view.frame.height))
        
        backgroudView = UIView(frame: dataSet.backgroudViewFrame)
        backImageView = UIImageView(frame: dataSet.backgroudImageFrame)
        titleLabel1 = UILabel(frame: dataSet.titleLabel1Frame)
        subTitleLabel = UILabel(frame: dataSet.subTitleLabelFrame)
        submitBt1 = PolicyButton(dataSet.submitBt1Frame)
        titleLabel2 = UILabel(frame: dataSet.titleLabel2Frame)
        submitBt2 = PolicyButton(dataSet.submitBt2Frame)
        closeBt = PolicyCloseBt(self)
        webView1 = UIWebView(frame: dataSet.webView1Frame)
        webView2 = UIWebView(frame: dataSet.webView2Frame)
        
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        
        let backgroudImg:UIImage? = UIImage(named: "img_provision_bigbox", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)?.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        if let bImg = backgroudImg {
            backImageView.image = bImg
        }
    
        
//        labelSet(titleLabel1, "estcommon_policy_title".localized(), UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1), 13)
//
//
//        labelSet(subTitleLabel, "estcommon_policy_subTitle".localized(), UIColor(red: 1, green: 95/255, blue: 95/255, alpha: 1), 10)
        
        
        if let weburl = webUrl1 {
            webView1.loadRequest(URLRequest(url: URL(string: weburl)!))
        }
        
        
        submitBt1.checkBtCallBack = checkBoxTrueClose

        
//        labelSet(titleLabel2, "estcommon_policy_privacy".localized(), UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1), 13)
        
        
        if let weburl = webUrl2 {
            webView2.loadRequest(URLRequest(url: URL(string: weburl)!))
        }
        
        
        submitBt2.checkBtCallBack = checkBoxTrueClose
        
        
        closeBt.frame = dataSet.closeBtFrame
        closeBt.closeBtActionCallBack = callbackFunc

        
        self.view.addSubview(backgroudView)
        backgroudView.insertSubview(backImageView, at: 0)
        backgroudView.addSubview(titleLabel1)
        backgroudView.addSubview(titleLabel2)
        backgroudView.addSubview(subTitleLabel)
        backgroudView.addSubview(webView1)
        backgroudView.addSubview(webView2)
        backgroudView.addSubview(submitBt1)
        backgroudView.addSubview(submitBt2)
        backgroudView.addSubview(closeBt)
    }
    
    public func isShowPolicyShow() -> Bool {
        let pList = UserDefaults.standard
        
        if pList.string(forKey: policyUserDefaultName) != nil && "true" == pList.string(forKey: policyUserDefaultName) {
            return false
        }
        return true
    }
    
    private func checkBoxTrueClose() {
        if (submitBt1.isChecked && submitBt2.isChecked) {
            let pList = UserDefaults.standard
            
            pList.set("true", forKey: policyUserDefaultName)
            pList.synchronize()
            self.dismiss(animated: false, completion: callbackFunc)
        }
    }
}
