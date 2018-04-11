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
import estgames_common_framework
//배너 생성 : 배너를 띄울 뷰를 매개변수로 보내준다.
var banner = bannerFramework(pview: self);
//배너 출력
banner.show();
```

### 이용약관 출력

### 이용약관 동의한 내용 가져오기

### 권한 출력

### 유저연동

### TODO

해상도 구분 .. 하드코딩된 상태..
가로모드 세로모드.. 라이브러리 내에서 구분하는 방법 찾아보기
