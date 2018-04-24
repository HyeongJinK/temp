# estgames-common-framework (이스트 게임즈 아이폰 공통 라이브러리)

[![CI Status](http://img.shields.io/travis/wkzkfmxk23@gmail.com/estgames-common-framework.svg?style=flat)](https://travis-ci.org/wkzkfmxk23@gmail.com/estgames-common-framework)
[![Version](https://img.shields.io/cocoapods/v/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![License](https://img.shields.io/cocoapods/l/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![Platform](https://img.shields.io/cocoapods/p/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)


## 개발설정

### cocoapods 라이브러리 등록

* 이스트 공통 모듈
 * pod 'estgames-common-framework', '~> 0.9.5' 

* 구글 모듈
 * pod 'GoogleSignIn', '~> 4.0.0'

### info.plist에 설정등록

### awsconfiguration.json 파일 추가

### Localizable.strings에 문자열 추가

### AppDelegate 설정


&nbsp;
&nbsp;


## 코드 구현

### 설정 (배너, 이용약관, 권한)관련 창

```swift
import estgames_common_framework    // 프레임워크 추가
//프레임 워크 선언
var estgamesCommon:EstgamesCommon!

override func viewDidLoad() {   //프레임 워크 초기화
super.viewDidLoad()
estgamesCommon = EstgamesCommon(pview: self) //배너, 이용약관, 권한..등을 띄울 뷰
}

```


### 설정된 순서대로 (배너, 이용약관, 권한) 출력

```swift
//콜백함수, 모든 로직이 완료된 후 호출하는 함수 구현
//구현하지 않으면 아무런 동작을 하지 않습니다.
//자료형 () -> Void
estgamesCommon.processCallBack = {() -> Void in}
//api 에서 제공하는 설정 순서대로 출력
estgamesCommon.processShow()
```


### 배너 출력

```swift
//배너 콜백 함수
//자료형 () -> Void
estgamesCommon.bannerCallBack
//배너 출력
estgamesCommon.bannerShow()
```

### 이용약관 출력

```swift
estgamesCommon.policyCallBack
estgamesCommon.policyShow()
```


### 이용약관 동의한 내용 가져오기

```swift
estgamesCommon.contractService()    //true or false
estgamesCommon.contractPrivate()
```

### 권한 출력

```swift
estgamesCommon.authorityCallBack
estgamesCommon.authorityShow()
```

### 유저연동

```swift
override func viewDidLoad() {
super.viewDidLoad()

vc = UserService(pview: self, googleEmail: googleEmail) //매개변수 : 유저연동 창이 나올 뷰, 구글메일(String)을 리턴하는 함수
}

/**
구글 메일주소를 리턴하는 함수
*/
import GoogleSignIn

func googleEmail() -> String {
    if let user = GIDSignIn.sharedInstance().currentUser {
        return user.profile.email
    } else {
        return ""
    }
}
```

### 게임시작(토큰 만들기)

```swift
//
vc.startGame()
}
```

### sns 계정연동(토큰이 있어야 합니다.)

```swift
vc.goToLogin()
}
```
