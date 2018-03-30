//
//  PolicyController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 28..
//

import Foundation

class PolicyDataSet {
    public var backgroudViewFrame:CGRect
    public var backgroudImageFrame:CGRect
    public var titleLabel1Frame:CGRect
    public var titleLabel2Frame:CGRect
    public var subTitleLabelFrame: CGRect
    public var webView1Frame:CGRect
    public var webView2Frame:CGRect
    public var submitBt1Frame: CGRect
    public var submitBt2Frame: CGRect
    public var closeBtFrame: CGRect
    
    init(deviceNum: Int) {
        if (deviceNum == 5) {
            backgroudViewFrame = CGRect(x: 41.5, y: 71.5, width: 293.5, height: 522.5)
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 13)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 18, y: 11, width: 18, height: 18)
        } else if (deviceNum == 6) {
            backgroudViewFrame = CGRect(x: 84, y: 43.5, width: 499, height: 286.5)
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 499, height: 286.5)
            titleLabel1Frame = CGRect(x: 0 , y: 29.5, width: backgroudViewFrame.width, height: 14)
            subTitleLabelFrame = CGRect(x: 0, y: 49, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 9999, y: 9999, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 26, y: 72.5, width: 219.5, height: 135.5)
            webView2Frame = CGRect(x: 253.5, y: 72.5, width: 219.5, height: 135.5)
            submitBt1Frame = CGRect(x: 26, y: 216.5, width: 220.5, height: 37.5)
            submitBt2Frame = CGRect(x: 253.5, y: 216.5, width: 220.5, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 18, y: 11, width: 18, height: 18)
        } else {
            backgroudViewFrame = CGRect(x: 41.5, y: 71.5, width: 293.5, height: 522.5)
            backgroudImageFrame = CGRect(x: 0, y: 0, width: 293.5, height: 522.5)
            titleLabel1Frame = CGRect(x: 0 , y: 39, width: backgroudViewFrame.width, height: 13)
            subTitleLabelFrame = CGRect(x: 0, y: 57, width: backgroudViewFrame.width, height: 10)
            titleLabel2Frame = CGRect(x: 0, y: 287, width: backgroudViewFrame.width, height: 13)
            webView1Frame = CGRect(x: 26.5, y: 78, width: 240, height: 135)
            webView2Frame = CGRect(x: 26.5, y: 311, width: 240, height: 134.5)
            submitBt1Frame = CGRect(x: 26.5, y: 221.5, width: 241, height: 37.5)
            submitBt2Frame = CGRect(x: 26.5, y: 454, width: 241, height: 37.5)
            closeBtFrame = CGRect(x: backgroudViewFrame.width - 10.5 - 18, y: 11, width: 18, height: 18)
        }
    }
}

class PolicyButton : UIButton {
    var isChecked: Bool = false
    
    let checkImage:UIImage
    let uncheckImage:UIImage
    
    init(_ frames: CGRect) {
        uncheckImage = UIImage(named: "btn_provision_off", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        checkImage = UIImage(named: "btn_provision_on", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        
        super.init(frame: frames)
        self.setBackgroundImage(uncheckImage, for: .normal)
        self.setTitle("동의합니다", for: .normal)
        self.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        uncheckImage = UIImage(named: "btn_provision_off", in:Bundle(for: PolicyButton.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        checkImage = UIImage(named: "btn_provision_on", in:Bundle(for: PolicyButton.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        super.init(coder: aDecoder)
    }
    
    @objc func clickEvent() {
        print("fdaf")
        isChecked = !isChecked
        if isChecked {
            self.setBackgroundImage(checkImage, for: .normal)
        } else {
            self.setBackgroundImage(uncheckImage, for: .normal)
        }
    }
}

class PolicyViewController: UIViewController {
    var backgroudView:UIView!
    var backImageView:UIImageView!
    var titleLabel1:UILabel!
    var titleLabel2:UILabel!
    var subTitleLabel: UILabel!
    var webView1:UIWebView!
    var webView2:UIWebView!
    var submitBt1: UIButton!
    var submitBt2: UIButton!
    var closeBt: PolicyCloseBt!
    var dataSet: PolicyDataSet!
    
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
        
        print(newSize.width)
        print(newSize.height)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    override func viewDidLoad() {
        dataSet = PolicyDataSet(deviceNum: DeviceClassification.deviceResolution(self.view.frame.width, self.view.frame.height))
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)

        backgroudView = UIView(frame: dataSet.backgroudViewFrame)
        backImageView = UIImageView(frame: dataSet.backgroudImageFrame)
        
        var backgroudImg = UIImage(named: "img_provision_bigbox", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        //var resizeImg = resizeImage(image: backgroudImg, targetSize: dataSet.backgroudViewFrame.size)
        backImageView.image = backgroudImg
        //backgroudView.backgroundColor = UIColor(patternImage: resizeImg)
    
        titleLabel1 = UILabel(frame: dataSet.titleLabel1Frame)
        titleLabel1.text = "이용약관"
        titleLabel1.textAlignment = .center
        titleLabel1.textColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        titleLabel1.font = UIFont.systemFont(ofSize: 13)
        
        subTitleLabel = UILabel(frame: dataSet.subTitleLabelFrame)
        subTitleLabel.text = "광고성 정보 수신 동의포함"
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = UIColor(red: 1, green: 95/255, blue: 95/255, alpha: 1)
        subTitleLabel.font = UIFont.systemFont(ofSize: 10)
        
        webView1 = UIWebView(frame: dataSet.webView1Frame)
        
        
        submitBt1 = PolicyButton(dataSet.submitBt1Frame)

        titleLabel2 = UILabel(frame: dataSet.titleLabel2Frame)
        titleLabel2.text = "개인정보 취급방침"
        titleLabel2.textAlignment = .center
        titleLabel2.textColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        titleLabel2.font = UIFont.systemFont(ofSize: 13)
        
        webView2 = UIWebView(frame: dataSet.webView2Frame)
        
        submitBt2 = PolicyButton(dataSet.submitBt2Frame)
        
        closeBt = PolicyCloseBt()
        //PolicyCloseBt()
        
        closeBt.frame = dataSet.closeBtFrame
//        let closeBtImage = UIImage(named: "btn_close_img", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!
//        closeBt.setImage(closeBtImage, for: .normal)
//        closeBt.addTarget(closeBt, action: #selector(testclick(_:)), for: .touchUpInside)
        
        //self.view.sendSubview(toBack: backgroudView)
        //self.view.insertSubview(backgroudView, at: 0)
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
    
    @objc func testclick(_ sender:UIButton) {
        print("dkafjkladjf")
    }
}
