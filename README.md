# estgames-common-framework

[![CI Status](http://img.shields.io/travis/wkzkfmxk23@gmail.com/estgames-common-framework.svg?style=flat)](https://travis-ci.org/wkzkfmxk23@gmail.com/estgames-common-framework)
[![Version](https://img.shields.io/cocoapods/v/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![License](https://img.shields.io/cocoapods/l/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![Platform](https://img.shields.io/cocoapods/p/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)

## 이스트 게임즈 아이폰 공통 라이브러리


### cocoapods 라이브러리 등록
pod 'estgames-common-framework', '~> 0.4.0'

### 배너 출력
```swift
import estgames_common_framework
//배너 생성 : 배너를 띄울 뷰를 매개변수로 보내준다.
var banner = bannerFramework(pview: self.view);
//배너 출력
banner.show();
```
