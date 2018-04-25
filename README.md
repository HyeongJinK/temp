# estgames-common-framework (이스트 게임즈 아이폰 공통 라이브러리)

[![Version](https://img.shields.io/cocoapods/v/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![License](https://img.shields.io/cocoapods/l/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)
[![Platform](https://img.shields.io/cocoapods/p/estgames-common-framework.svg?style=flat)](http://cocoapods.org/pods/estgames-common-framework)


:page_with_curl: 개발에 필요한 프로젝트 설정 
===

### :one: cocoapods 라이브러리 등록 (Podfile에 추가)

* 이스트 공통 모듈
* pod 'estgames-common-framework', '~> 0.9.5' 

* 구글 모듈
* pod 'GoogleSignIn', '~> 4.0.0'

### :two: info.plist에 설정등록 :warning: 아래 값은 예시일 뿐이며 정확한 설정 값은 웹플랫폼팀에 문의 부탁드립니다.

```xml
<key>MP</key>
<dict>
    <key>app_id</key>
    <string>ffarm</string>
    <key>region</key>
    <string>ffg.global.ls</string>
    <key>app_name</key>
    <string>노바워즈</string>
    <key>client_id</key>
    <string>b9b2b750-ea07-3808-a7b1-9f9ca4a9ffab.mp.estgames.com</string>
    <key>secret</key>
    <string>15624467fd9b22c7f592de53ca92c0ed49a3ba1945a40116926c4edf1209f75c</string>
    <key>estapi</key>
    <string>https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/live/start/ffg.global.ls</string>
</dict>
<key>AWS</key>
<dict>
    <key>CredentialsProvider</key>
    <dict>
        <key>CognitoIdentity</key>
        <dict>
            <key>Default</key>
            <dict>
                <key>PoolId</key>
                <string>ap-northeast-2:f3e54d03-7439-43ae-a846-d4bfd7e9c980</string>
                <key>Region</key>
                <string>ap-northeast-2</string>
            </dict>
        </dict>
    </dict>
    <key>MobileHub</key>
    <dict>
        <key>ProjectClientId</key>
        <string>MobileHub fcaa397e-1a87-44ca-ae36-dbc5e538b33d aws-my-sample-app-ios-swift-v0.19</string>
    </dict>
    <key>PinpointAnalytics</key>
    <dict>
        <key>Default</key>
        <dict>
            <key>AppId</key>
            <string>6e716976d2d04a0daf7525fb4ca03b41</string>
            <key>Region</key>
            <string>us-east-1</string>
        </dict>
    </dict>
    <key>PinpointTargeting</key>
    <dict>
        <key>Default</key>
        <dict>
            <key>Region</key>
            <string>us-east-1</string>
        </dict>
    </dict>
</dict>
<key>FacebookAppID</key>
<string>1641813522553524</string>
<key>FacebookDisplayName</key>
<string>FFG-facebook</string>
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.amazon.MySampleApp</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.915170168211-65if7jlchf26id1vp2d2n975caau82ik</string>
            <string>fb1641813522553524</string>
            <string>com.amazon.mysampleapp</string>
        </array>
    </dict>
</array>
```

#### MP

|이름|타입|설명|(예)
|-|-|-|-|
|app_id|String|앱아이디|ffarm|
|region|String||ffg.global.ls|
|app_name|String|앱이름|노바워즈|
|client_id|String||b9b2b750-ea07-3808-a7b1-9f9ca4a9ffab.mp.estgames.com|
|secret|String||15624467fd9b22c7f592de53ca92c0ed49a3ba1945a40116926c4edf1209f75c|
|estapi|String|공통 모듈에서 사용하는 api 주소|https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/live/start/ffg.global.ls|

### :three: awsconfiguration.json 파일 추가 :warning: 아래 값은 예시일 뿐이며 정확한 설정 값은 웹플랫폼팀에 문의 부탁드립니다.

```json
{
    "UserAgent": "MobileHub/1.0",
    "Version": "1.0",
    "CredentialsProvider": {
        "CognitoIdentity": {
            "Default": {
                "PoolId": "ap-northeast-2:f3e54d03-7439-43ae-a846-d4bfd7e9c980",
                "Region": "ap-northeast-2"
            }
        }
    },
    "IdentityManager": {
        "Default": {}
    },
    "PinpointAnalytics": {
        "Default": {
            "AppId": "6e716976d2d04a0daf7525fb4ca03b41",
            "Region": "us-east-1"
        }
    },
    "PinpointTargeting": {
        "Default": {
            "Region": "us-east-1"
        }
    },
    "GoogleSignIn": {
        "ClientId-iOS": "915170168211-65if7jlchf26id1vp2d2n975caau82ik.apps.googleusercontent.com",
        "Permissions": "email,profile,openid"
    },
    "FacebookSignIn": {
        "AppId": "1641813522553524",
        "Permissions": "public_profile"
    }
}


```

### :four: Localizable.strings에 문자열 추가 (로컬라이징)

```
'estcommon_policy_title' = "이용약관";
'estcommon_policy_subTitle' = "광고성 정보 수신 동의포함";
'estcommon_policy_privacy' = "개인 정보 취급방침";

'estcommon_authority_title' = "원활한 게임플레이를 위해 아래 권한을 필요로 합니다.";
'estcommon_authority_confirm' = "확인";

'estcommon_userResult_title' = "알림";
'estcommon_userResult_subTitle' = "불러오기 성공";
'estcommon_userResult_titleMove' = "게임 재 구동을 위해 타이틀 화면으로 이동합니다.";
'estcommon_userResult_confirm' = "확인";

'estcommon_userLoad_title' = "기존 계정 불러오기";
'estcommon_userLoad_content' = "현재 게스트 모드로 플레이 중인 데이터([])를\n삭제하고 기존 데이터를 불러오시려면 아래 문자를 입력해주세요.";
'estcommon_userLoad_confirmText' = "확인 문자 : confirm";
'estcommon_userLoad_input' = "입력하기";
'estcommon_userLoad_confirmButton' = "확인";

'estcommon_userLink_title' = "계정 연동";
'estcommon_userLink_middelLabel' = "입력하신 계정에 이미 플레이 중인 데이터가 있습니다.\nFacebookAccount: []\n위의 데이터를 불러오시겠습니까?";
'estcommon_userLink_bottomLabel' = "!현재 플레이 중인 게임데이터([])는 삭제됩니다";
'estcommon_userLink_confirm' = "네, 불러오겠습니다";
'estcommon_userLink_cancel' = "아니오, 새로 연동하기";

'estcommon_banner_closeButton' = "닫기";
'estcommon_banner_linkButton' = "자세히 보기";
'estcommon_banner_oneDay' = "오늘 다시보지않기";

'estcommon_userGuest_title' = "현재 계정 연동";
'estcommon_userGuest_middle' = "기존 연동된 데이터 ([])를 삭제하고 현재 플레이중인 게임 데이터로 계정연동을 진행합니다.";
'estcommon_userGuest_bottom' = "\n[]";
'estcommon_userGuest_loginBt' = "네,로그인합니다";
'estcommon_userGuest_beforeBt' = "이전으로 돌아가기";

```

### :five: AppDelegate 에 소스 코드 추가

```swift
static let remoteNotificationKey = "RemoteNotification"
var estAppDelegate: EstAppDelegate = EstAppDelegate()

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    return estAppDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
}

func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return estAppDelegate.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    print("google: application")

    return GIDSignIn.sharedInstance().handle(url,
        sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
        annotation: options[UIApplicationOpenURLOptionsKey.annotation])
}
```

### :six: 구글 이메일 계정 가지고 오는 함수 생성

```swift
import GoogleSignIn     //구글 프레임워크 추가

func googleEmail() -> String {
    if let user = GIDSignIn.sharedInstance().currentUser {
        return user.profile.email
    } else {
        return ""
    }
}
```

&nbsp;
&nbsp;


:pencil: 코드 구현
===

:mag: 공통으로 사용되는 창
---

### :exclamation: 초기설정 (배너, 이용약관, 권한)관련 창

```swift
import estgames_common_framework    // 프레임워크 추가
//프레임 워크 선언
var estgamesCommon:EstgamesCommon!

override func viewDidLoad() {   //프레임 워크 초기화
    super.viewDidLoad()
    estgamesCommon = EstgamesCommon(pview: self) //배너, 이용약관, 권한..등을 띄울 뷰
}

```


### :computer: 설정된 순서대로 (배너, 이용약관, 권한)

```swift
//콜백함수, 모든 로직이 완료된 후 호출하는 함수 구현
//구현하지 않으면 아무런 동작을 하지 않습니다.
//자료형 () -> Void
estgamesCommon.processCallBack = {() -> Void in}
//api 에서 제공하는 설정 순서대로 출력
estgamesCommon.processShow()
```

#### :mag: 관련함수 및 매개 변수 

|이름|설명|
|-|-|
|processShow()|나라별로 설정된 순서로 출력하게 하는 함수|
|processCallBack: () -> Void|모든 출력이 끝난 후에 출력되는 콜백 함수|


### :computer: 배너

```swift
//배너 콜백 함수
//자료형 () -> Void
estgamesCommon.bannerCallBack = {() -> Void in}
//배너 출력
estgamesCommon.bannerShow()
```

#### :mag: 관련함수 및 매개 변수 

|이름|설명|
|-|-|
|bannerShow()|배너창 출력|
|bannerCallBack: () -> Void|배너창이 종료된 후 콜백함수|



### :computer: 이용약관

```swift
estgamesCommon.policyCallBack = {() -> Void in}
estgamesCommon.policyShow()
estgamesCommon.contractService()    //true or false
estgamesCommon.contractPrivate()
```

#### :mag: 관련함수 및 매개 변수 

|이름|설명|
|-|-|
|policyShow()|배너창 출력|
|policyCallBack: () -> Void|이용약관창이 종료된 후 콜백함수|
|contractService() -> Bool|서비스 이용약관 동의 여부|
|contractPrivate() -> Bool|개인 이용약관 동의 여부|


### :computer: 권한

```swift
estgamesCommon.authorityCallBack = {() -> Void in}
estgamesCommon.authorityShow()
```

#### :mag: 관련함수 및 매개 변수 

|이름|설명|
|-|-|
|authorityShow()|권한확인창 출력|
|authorityCallBack: () -> Void|권환확인창이 종료된 후 콜백함수|


:bust_in_silhouette: 계정관련
---

### :exclamation:  유저연동 초기 설정

```swift
import estgames_common_framework    // 프레임워크 추가

override func viewDidLoad() {
    super.viewDidLoad()

    vc = UserService(pview: self, googleEmail: googleEmail) 
    //매개변수 : 유저연동 창이 나올 뷰, 구글메일(String)을 리턴하는 함수
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

### :computer: 게임시작(토큰 만들기)

```swift
// 게임 시작 시 호출 필요
vc.startGame()
Mpinfo.Account.userId
```

#### :mag: 관련함수 및 매개 변수 

|이름|설명|
|-|-|
|startGame()|토큰생성|
|startSuccessCallBack: () -> Void|토큰생성 성공시 콜백 함수|
|startFailCallBack: () ->(message:String)|토큰 생성 실패시 콜백 함수|

#### :open_file_folder: 토큰 생성 후 유저 정보 불러오기

|호출 코드|설명|
|-|-|
|MpInfo.Account.egId|egId|
|MpInfo.Account.egToken|egToken|
|MpInfo.Account.refreshToken|refreshToken|
|MpInfo.Account.principal|principal|
|MpInfo.Account.provider|[guest,facebook,google]|
|MpInfo.Account.email|이메일|
|MpInfo.Account.device|device|
|MpInfo.Account.userId|유저 아이디|

#### :no_entry: 실패 메시지

|실패 메시지|설명|
|-|-|
|TOKEN_CREATE|토큰 생성 실패|
|PRINCIPAL_APICALL|유저정보 가져오는 API 호출실패(네트워크 확인)|

### :computer: sns 계정연동(토큰이 있어야 합니다.)

```swift
// 게임 토큰이 필요합니다. 없을 경우 에러 발생
vc.goToLogin()
```

#### :mag: 관련함수 및 매개 변수 

|이름|설명|
|-|-|
|goToLogi()|SNS 계정연동 시작|
|startSuccessCallBack: () -> Void|토큰생성 성공시 콜백 함수|
|goToLoginFailCallBack: () ->(message:String)|계정연동 실패시 콜백함수|
|goToLoginConfirmCallBack: () -> Void|SNS 계정 연동 중 confirm 입력 창에 값 입력 실패 시 호출되는 콜백함수 구현하지 않으면 아무일도 하지 않는 다.|


#### :no_entry: 실패 메시지

|실패 메시지|설명|
|-|-|
|EMPTY_TOKEN|토큰이 없습니다. 게임 시작으로 토큰을 먼저 만드세요|
|READY_SNSLOGIN|이미 SNS계정에 연동이 되어 있는 계정입니다.|
|AWS_LOGINVIEW|AWS 로그인창을 불러오는 과정 중 에러|
|EMPTY_GOOGLECALLBACK|구글 계정 연동 시 구글메일 콜백함수가 구현이 안되었을 때
|SNS_SYNC|SNS 연동 후 이상한 리턴값|
|SNS_SYNC_FAIL|연동 중 에러 발생|
|SNS_LOGIN|로그인 된 계정 정보로 새로운 토큰 만들 때 에러|
|PRINCIPAL_APICALL|유저정보 가져오는 API 호출실패(네트워크 확인)|
|GUEST_LOGIN|게스트 계정으로 싱크 중 에러|
|CHARACTER_INFO|캐릭터 정보 가져오는 중 에러|

