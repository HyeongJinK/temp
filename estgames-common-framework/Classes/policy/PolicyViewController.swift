//
//  PolicyController.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 3. 28..
//

import Foundation

class PolicyViewController: UIViewController {
    var backgroudView:UIView!
    var backImageView:UIImageView!
    var titleLabel1:UILabel!
    var titleLabel2:UILabel!
    var subTitleLabel: UILabel!
    var webView1:UIWebView!
    var webView2:UIWebView!
    var submitBt1: PolicyButton!
    var submitBt2: PolicyButton!
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
    
    func labelSet(_ label:UILabel, _ text:String, _ color:UIColor, _ size:CGFloat) {
        label.text = text
        label.textAlignment = .center
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)//UIFont.init(name: "SpoqaHanSans", size: size)
    }
    
    override func viewDidLoad() {
        dataSet = PolicyDataSet(deviceNum: DeviceClassification.deviceResolution(self.view.frame.width, self.view.frame.height))
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)

        backgroudView = UIView(frame: dataSet.backgroudViewFrame)
        backImageView = UIImageView(frame: dataSet.backgroudImageFrame)
        
        let backgroudImg = UIImage(named: "img_provision_bigbox", in:Bundle(for: PolicyViewController.self), compatibleWith:nil)!.stretchableImage(withLeftCapWidth: 5, topCapHeight: 5)
        //var resizeImg = resizeImage(image: backgroudImg, targetSize: dataSet.backgroudViewFrame.size)
        backImageView.image = backgroudImg
        //backgroudView.backgroundColor = UIColor(patternImage: resizeImg)
    
        titleLabel1 = UILabel(frame: dataSet.titleLabel1Frame)
        labelSet(titleLabel1, NSLocalizedString("estcommon_policy_title", comment: ""), UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1), 13)
        
        subTitleLabel = UILabel(frame: dataSet.subTitleLabelFrame)
        labelSet(subTitleLabel, NSLocalizedString("estcommon_policy_subTitle", comment: ""), UIColor(red: 1, green: 95/255, blue: 95/255, alpha: 1), 10)
        
        webView1 = UIWebView(frame: dataSet.webView1Frame)
        webView1.loadRequest(URLRequest(url: URL(string: "https://s3.ap-northeast-2.amazonaws.com/m-static.estgames.co.kr/mpsdk/ffg.global.ls/contract/agreement.html")!))
        
        submitBt1 = PolicyButton(dataSet.submitBt1Frame)

        titleLabel2 = UILabel(frame: dataSet.titleLabel2Frame)
        labelSet(titleLabel2, NSLocalizedString("estcommon_policy_privacy", comment: ""), UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1), 13)
        
        webView2 = UIWebView(frame: dataSet.webView2Frame)
        webView2.loadRequest(URLRequest(url: URL(string: "https://s3.ap-northeast-2.amazonaws.com/m-static.estgames.co.kr/mpsdk/ffg.global.ls/contract/privacy.html")!))
        
        submitBt2 = PolicyButton(dataSet.submitBt2Frame)
        
        closeBt = PolicyCloseBt(self)
        closeBt.frame = dataSet.closeBtFrame

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
}
