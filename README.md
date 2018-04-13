# estgames-common-framework

[![CI Status](http://img.shields.io/travis/wkzkfmxk23@gmail.com/estgames-common-framework.svg?style=flat)](https://travis-ci.org/wkzkfmxk23@gmail.com/estgames-common-framework)
[![Version](https://img.shields.io/cocoapods/v/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![License](https://img.shields.io/cocoapods/l/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![Platform](https://img.shields.io/cocoapods/p/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)

# 이스트 게임즈 아이폰 공통 라이브러리

## 개발방법

### cocoapods 라이브러리 등록

* 이스트 공통 모듈

pod 'estgames-common-framework', '~> 0.7.0' 

* 계정연동에 필요한 AWS  모듈들

pod 'AWSAuthCore', '~> 2.6.1'
pod 'AWSPinpoint', '~> 2.6.1'
pod 'AWSGoogleSignIn', '~> 2.6.1'
pod 'GoogleSignIn', '~> 4.0.0'
pod 'AWSFacebookSignIn', '~> 2.6.1'
pod 'AWSCognito', '~> 2.6.1'
pod 'AWSAuthUI', '~> 2.6.1'
pod 'Alamofire', '~> 4.7'
pod 'SwiftKeychainWrapper'


### 배너 출력

```swift
import estgames_common_framework    // 프레임워크 추가
//프레임 워크 선언
var estgamesCommon:EstgamesCommon!

override func viewDidLoad() {   //프레임 워크 초기화
super.viewDidLoad()
estgamesCommon = EstgamesCommon(pview: self) //배너, 이용약관, 권한..등을 띄울 뷰
}

//배너 출력
estgamesCommon.bannerShow()
```

### 이용약관 출력

```swift
estgamesCommon.policyShow()
```


### 이용약관 동의한 내용 가져오기

```swift
estgamesCommon.contractService()    //true or false
estgamesCommon.contractPrivate()
```

### 권한 출력

```swift
estgamesCommon.authorityShow()
```

### 유저연동

```swift
```
