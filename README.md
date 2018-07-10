# estgames-common-framework (이스트 게임즈 안드로이드 공통 라이브러리)

## 업데이트 사항

:new: 1.3.0 업데이트 사항
* SNS 계정연결시 사용자 정보를 조회하지 못하는 경우 실패 처리 하고 실패 콜백을 호출하도록 수정
* 사용자 정보 조회 실패시 에러코드는 API_CHARACTER_INFO 입니다.

:new: 1.2.1 업데이트 사항
* 세션 (eg_token) 관리를 IOS SDK 와 동일하게 Region 별로 관리하도록 수정
  * 중간에 region을 변경해도 앱을 다시 설치할 필요가 없습니다.
* 계정 연동 알림창의 오타 수정
* SNS 로그인시 특정기기에서 진행이 멈추는 오류 수정

:new: 1.2.0 업데이트 사항
* SNS 로그인 레이아웃 개선 - 배경화면 및 SNS 로그인 버튼 레이아웃 수정
* SDK 의 언어 설정 기능 추가
* 배너 이미지 크기 조절 방식 변경
  * 비율유지 전체화면 -> 비율유지 이미지 자름으로 변경되었습니다.
  * 이미지 뷰의 레터박스가 사라지고 기기 화면의 크기에 맞게 이미지가 재조정되어 보입니다.
* GameAgent 클래스 추가
  * 게임서비스의 오픈 여부를 확인하는 API를 추가했습니다.
* SNS 사용자 계정 연계시 사용자 email 정보 획등
  * 이제 AOS SDK 에서도 계정 연계시 사용자의 email 정보를 저장합니다.
  * 구글 로그인의 경우 Google-SDK 버전을 확인하셔야 합니다.
  * 그래들 dependencies 설정에 **implementation 'com.google.android.gms:play-services-auth:15.0.1'** 를 추가해주세요.
* PlatformContext 설정 옵션이 추가되었습니다.

:new: 1.1.0 업데이트 사항
* showEvent() 함수 추가 : 이벤트 페이지를 보여주는 웹뷰 다이얼로그 입니다.
* 배너 기능 추가
  * 웹배너 등록 - 이미지 배너 뿐만 아니라 웹 배너도 등록하고 보여줄 수 있습니다.
  * 베너 버튼 커스터마이징 기능 - 배너 버튼의 이름을 관리자가 등록 하고 변경 할 수 있습니다.
* 앱 Configuration 개선 : Option 정보를 이용해서 코드에서 Configuration 값을 조정 할 수 있습니다.
  * Option 클래스 추가
  * Configuration 정보 지연 설정 기능 추가
* 라이브러리 리소스의 다국어 지원
  * Default 언어가 영어로 변경되었습니다.
  * 현재 지원하는 언어는 영어와 한국어입니다.
* UserService 의 CustomSupplier 등록 기능 삭제 : 로그인계정 충돌시 다이얼로그에 텍스트를 전달해 주지 않아도 됩니다.
* processShow 수정
  * 약관동의 화면에서 약관 동의 거부할 경우 클라이언트에 실패 메시지 ( ***PROCESS_CONTRACT_DENIED*** )를 돌려주며 진행을 멈추도록 수정했습니다.


:new: 1.0.10 업데이트 사항
* 로그인 계정연동 팝업 뒤로가기 버튼 동작 버그 수정
* 로그인 계정연동 핸들러 변경. 로그인 계정 연동시 계정 충돌 다이얼러로그 창 동작 결과에 대한 핸들러를 새로 작성하였습니다.
  * UserService의 FailCallback의 역할이 분리되었습니다. : FailCallback 은 게임 시작 동작에만 관여하고, 로그인 계정연동 핸들러는 새롭게 정의했습니다.
  * 로그인 계정 연동 핸들러는 세가지 상태에 대한 핸들러를 등록 하도록 수정했습니다. : onComplete / onFail / onCancel


:new: 1.0.9 업데이트 사항

* 계정연동 팝업 버그 수정
* 계정연동 호출을 실제로 변경했습니다. 앱을 지우고 다시 설치해야 제대로 동작합니다.
* 이용약관 전부 동의하기 했을 경우 더 이상 나오지 않습니다.(앱을 지우고 다시 설치하면 나옵니다.)
* 팝업크기가 이상할 텐데 수정예정입니다.
* goToLogin(AuthUIConfiguration config) 함수가 추가 되었습니다. 해당 함수로 SNS로그인 화면 일부 수정가능합니다.

  ```java
    AuthUIConfiguration config = new AuthUIConfiguration
            .Builder()
            .signInButton(FacebookButton.class)
            .signInButton(GoogleButton.class)
            .userPools(false)
            .build();
    empUserService.goToLogin(config);
    //기본적인 설정
    //추가적으로 배경색, 로그이미지 변경을 할 수 있습니다.
  ``` 

* :exclamation: ERROR_CODE 이름이 Fail로 변경되었습니다.
* :exclamation: UserService 부분에 에러 콜백이 failCallBack으로 통합되었습니다. 이제 에러가 날 경우 모두 저 콜백함수를 호출합니다.
  * failCallBack의 타입은 CustomConsumer\<Fail> 입니다.
* EstCommonFramework의 에러 콜백은 estCommonFailCallBack 을 호출합니다.
  * 타입은 CustomConsumer\<Fail> 입니다.



:new: 1.0.8 업데이트 사항

* 계정연동 팝업 dialog dismiss 함수는 원인을 찾고 있습니다.
* :exclamation: 유저 아이디 추가 Profile에 추가 되었습니다.
  * 해당 사항 추가로 인해 기존에 설치된 게임에서 실행할 경우 유저 아이디가 없어 에러가 납니다. 삭제 후 다시 설치한 후 실행해 주세요. 
* :exclamation: UserService 클래스 선언시 매개변수가 수정되었습니다.
  * new UserSerivce(this, this.getApplicationContext()); ----> new UserSerivce(this);
* :exclamation: 뒤로가기가 수정되었습니다. 아래코드를 goToLogin함수 호출 전에 추가해 주세요

    ```java
    empUserService.setBack(new CustomConsumer<Activity>() {
        @Override
        public void accept(Activity activity) {
            activity.startActivity(new Intent(activity, MRActivity.class));
        }
    });
    ```
    
* 배너 관련 버그 수정되었습니다.
* EstCommonFramework에 estCommonFailCallBack이 추가 되었습니다.
  * 타입은 CustomConsumer<ERROR_CODE> 이며 ERROR_CODE에 에러 이유가 정의 되어 있습니다.
* ERROR_CODE  : 에러 코드는 더 추가될 예정입니다.
    * PRINCIPAL_APICALL   //네트워크 에러

:new: 1.0.7 업데이트 사항

* systemContractShowOrDismiss() 함수 추가 (권한창이 나와야 하는 지 확인)
* processShow() 에서 권한창(authority)이 더 이상 나오지 않습니다.
* systemContractShowOrDismiss() 함수를 호출해서 true일 경우 authorityShow() 함수를 호출하고 콜백으로 Manifest에 있는 권한 동의 팝업창을 띄우는 형식으로 되어야 합니다.
* 유저 권한 팝업 텍스트 설정 함수인터페이스 추가
  * CustormSupplier setUserLinkMiddleText
    * 입력하신 계정에 이미 플레이 중인 데이터가 있습니다.\nFacebookAccount: []\n위의 데이터를 불러오시겠습니까?
  * CustormSupplier setUserLinkBottomText
    * !현재 플레이 중인 게임데이터([])는 삭제됩니다
  * CustormSupplier setUserLoadText
    * 현재 게스트 모드로 플레이 중인 데이터([])를\n삭제하고 기존 데이터를 불러오시려면 아래 문자를 입력해주세요.
  * CustormSupplier setUserGuestText
    * 기존 연동된 데이터 ([])를 삭제하고 현재 플레이중인 게임 데이터로 계정연동을 진행합니다.\n[]

:new: 1.0.6 업데이트 사항

* :exclamation: AWSConfiguration 클래스 추가 - Application.java 설정부분이 변경되었습니다.
* :exclamation: 사용자 정보 가져오는 부분이 변경되었습니다.  참고: (3. 유저 연동 프로세스 - 5. 정보 가져오기)
* 이용약관 체크박스 누를경우 이미지가 변경되는 부분에서 체크 되었을 경우 변하는 걸로 수정
* EstCommonFramework에 getNation()[나라], getLanguage()[언어] 함수 추가
* processShow() 함수 버그 수정

:new: 1.0.5 업데이트 사항

* (5/11 5시 20분 이후) 웹뷰추가(공지사항, 고객센터), 디자인이 없어서 미적용 상태
* authorityShow() 수정
* EstCommonFramework 객체 생성 시 startApi 미호출, 해당 객체에 create 함수 호출 시 startApi 호출하여 값 설정
* create 함수 callback
* checkSignature() 삭제

## :page_with_curl: Android App 프로젝트 설정

### 라이브러리 import
안드로이드 프로젝트는 기본적으로 gradle을 기반으로 프로젝트를 구성합니다.
EGMP SDK를 사용하기 위해 build.gradle 파일에 의존성 정보를 등록합니다.

###### build.gradle
```gradle
....
dependencies {
    // Google SDK 를 사용하기위한 모듈
    implementation 'com.google.android.gms:play-services-auth:15.0.1'

    //AWS를 사용하기 위한 공통 모듈
    implementation 'com.android.support:multidex:1.0.1'
    implementation 'com.amazonaws:aws-android-sdk-core:2.6.0'
    implementation 'com.amazonaws:aws-android-sdk-cognito:2.6.0'
    implementation('com.amazonaws:aws-android-sdk-auth-core:2.6.0@aar') { transitive = true; }
    implementation('com.amazonaws:aws-android-sdk-auth-userpools:2.6.7@aar') { transitive = true; }
    implementation('com.amazonaws:aws-android-sdk-auth-ui:2.6.7@aar') { transitive = true; }
    implementation('com.amazonaws:aws-android-sdk-auth-facebook:2.6.7@aar') { transitive = true; }
    implementation('com.amazonaws:aws-android-sdk-auth-google:2.6.7@aar') { transitive = true; }

    //이스트 게임즈 공통 모듈
    implementaion 'com.estgames.estgames_framework:app-release2:1.0@aar'
    ...
}
```

:warning: 현재 EGMP 플랫폼에서는 라이브러리 저장소를 제공하지 않습니다.
**app-release2.aar** 파일을 다운로드 받아 import 할 경우 로컬 repository를 설정해주세요.
해당 파일은 gitlab에 lib 폴더 안에 있습니다.
> 예: 라이브러리 파일을 프로젝트의 **libs** 디렉토리 아래에 위치시킬 경우
```gradle
repositories {
    flatDir {
        dirs 'libs'
    }
}
```

### AndroidManifest.xml 설정
안드로이드 앱에서 MP SDK 의 라이브러리를 사용하기 위해서는 안드로이드의 Manifest.xml 파일에 몇가지 설정이 추가 되어야 합니다.

#### package name 설정
사용자 계정을 외부 OPEN ID 서비스의 계정을 사용하여 연동할 경우 각 프로바이더들의 클라이언트 설정에 package name 을 필요로 합니다.
IDE 툴을 사용하여 프로젝트를 생성했을 경우 package name 을 수정할 필요는 없습니다.

:warning: 일부 OPEN ID 서비스의 경우 (google+) package name 정보가 일치하지 않는 경우 계정 연동에 실패합니다.

```xml

<manifest xmlns:android="http://schemas.android.com/apk/res/android" pacakage="net.sample.android.app">
    ...
</manifest>

```

#### users-permission 설정

EGMP 서비스들은 모두 웹 기반의 API 입니다. 따라서 모바일 앱에서 인터넷 및 네트워크 관련 권한설정을 해야 합니다.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android" ... >
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    ...
</manifest>
```

#### Facebook 로그인 설정 (Option)

Android App 에서 Facebook 계정으로 로그인 연동을 하는 경우 Manefest.xml 파일에 페이스북 관련 설정을 해야합니다.
페이스북 로그인은 페이스북 로그인 창을 위한 Activity 등록과 페이스북 앱 인증을 위한 meta-data 설정이 필요합니다.
facebook app id 등의 리소스를 분리할 경우 res/values/string.xml 파일에 리소스를 등록해줍니다.

###### Facebook Login Activity 등록
```xml
<manifest ... >
    <application ...>
        <activity
            android:name="com.facebook.FacebookActivity" android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="@string/fb_login_protocol_scheme" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

###### Facebook meta-data 설정
```xml
<manifest ... >
    <application ...>
        <meta-data
            android:name="com.facebook.sdk.ApplicationId"
            android:value="@string/facebook_app_id" />
    </application>
</manifest>
```

###### Facebook 설정을 위한 리소스 등록 (res/values/string.xml)

**fb_login_protocol_scheme** 값은 fb + [facebook_app_id] 형태로 입력해주시면 됩니다.
> 예) fb1234567893456

```xml
<resource>
    <string name="facebook_app_id">[facebook_app_id]</string>
    <string name="fb_login_protocol_scheme">fb[facebook_app_id]</string>
</resource>
```


### Client 설정정보 import

EGMP SDK 는 ***res/raw*** 디렉토리에 위치한 설정 파일을 읽어 framework 초기화를 실행합니다.
따라서 SDK에서 필요한 설정 파일을 해당 디렉토리(***res/raw***) 아래에 위치시켜야 합니다.
필요한 파일은 다음과 같습니다.

 - awsconfiguration.json
 - egconfiguration.json

설정 파일은 MP Console 에서 다운로드를 제공할 예정입니다.

###### awsconfiguration.json
EGMP SDK 는 AWS Congito 서비스를 기반으로 사용자 연동 서비스를 제공합니다. 따라서 AWS 설정 정보를 포함해야 합니다.
```json
{
  "UserAgent": "MobileHub/1.0",
  "Version": "1.0",
  "CredentialsProvider": {
    "CognitoIdentity": {
      "Default": {
        "PoolId": "ap-northeast-2:492ef421-4fad-43d9-ac21-5f549c7acd65",
        "Region": "ap-northeast-2"
      }
    }
  },
  "IdentityManager": {
    "Default": {}
  },
  "GoogleSignIn": {
    "ClientId-WebApp": "825002676307-amcdnvgcdn69i3uqtf2p7uk8il1o0jla.apps.googleusercontent.com",
    "ClientId-iOS": "825002676307-etghc2c1aiqcq5m5duh457gir198mtbg.apps.googleusercontent.com",
    "Permissions": "email,profile,openid"
  },
  "FacebookSignIn": {
    "AppId": "188102531988315",
    "Permissions": "public_profile"
  }
}
```

###### egconfiguration.json
EGMP 서비스를 사용하기 위해서는 MP Console에 등록된 어플리케이션 설정 정보를 포함해야 합니다.
```json
{
  "Client" : {
    "ClientId": "1cbfa4da-f456-36cd-95f7-c17938d1b1b5.mp.estgames.com",
    "Secret": "435e1b2e970676e51826000ea3ef00fe0b43847866a7e95ff8903942f91a137c",
    "Region": "mr.global.qa"
  }
}
```

## 안드로이드 앱 빠르게 시작하기

안드로이드 앱에서 EGMP 서비스를 사용하기 위해서는 AWS와 EGMP 설정을 기반으로 앱 Context를 초기화하고 구성해야 합니다.
이 예제에서는 안드로이드 프레임워크의 `Application` 클래스를 이용해 Context 를 구성하도록 하겠습니다.

:warning:  `Application` 클래스는  프로젝트의 패키지 최상위 레벨에 위치 시키도록 합니다.

### AWS Configuration 구성

EGMP의 로그인 인증 서비스는 AWS Cognito를 기반으로 동작합니다. 따라서 Aws Configuration 및 login 을 위한 IdentityManager를 초기화해야 합니다.

`AwsConfiguration` 을 초기화 하고 Cognito 인증을 위한 `IdentityManager`를 등록합니다.
기본 `IdentityManager`를 등록한 후 Facebook, Google 등의 Signin Provider를 `IdentityManager` 에 등록합니다.

###### Application.java
```java
class Appication extends MultiDexApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        initializeAws();
        ...
    }

    private void initializeAws() {
        // AwsConfiguration 초기화 및 생성
        AWSConfiguration awsCfg = new AWSConfiguration(applicationContext());

        // Cognito 인증을 위한 Default IdentityManager 설정
        if (IdentityManager.getDefaultIdentityManager() == null) {
            IdentityManager manager = new IdentityManager(applicationContext(), awsCfg);
            IdentityManager.setDefaultIdentityManager(manager);
        }

        FacebookSignInProvider.setPermissions("public_profile");
        GoogleSignInProvider.setPermissions(Scopes.EMAIL, Scopes.PROFILE);

        IdentityManager.getDefaultIdentityManager().addSignInProvider(FacebookSignInProvider.class)
        IdentityManager.getDefaultIdentityManager().addSignInProvider(GoogleSignInProvider.class)
    }
}
```


### PlatformContext 구성

EGMP 서비스를 이용하기 위해 MP Configuration을 초기화 하고 Context를 구성하도록 합니다.
Application 클래스를 MP Context로 인식 할 수 있도록 PlatformContext 인터페이스를 구현합니다.

> `AwsPlatformContext` 클래스는 위에 언급한 AWS 설정을 만들어주는 역할을 하는 클래스입니다. 이 클래스를 사용해 Application 클래스를 구성하면 따로 AWS 구성 코드를 작성하지 않아도 됩니다.

###### Application.java
``` java
public class Application extends MultiDexApplication implements PlatformContext {
    private PlatformContext delegateContext;

    @Override
    public Configuration getConfiguration() {
        return delegateContext.getConfiguration();
    }

    @Override
    public String getDeviceId() {
        return delegateContext.getDeviceId();
    }

    @Override
    public SessionRepository getSessionRepository() {
        return delegateContext.getSessionRepository();
    }

    @Override
    public void onCreate() {
        super.onCreate();
        this.delegateContext = new AwsPlatformContext(getApplicationContext());
    }
}
```

##### Configuration 속성 관리

`Configuration.Option`  클래스를 이용해 설정값을 등록 할 수 있습니다. 이 옵션을 사용하면 `egconfiguration.json` 파일에 기술된 속성과 다른 값을 적용하여 설정을 구성 할 수 있습니다.

```java
    Configuration.Option option = new Configuration.Option()
                                      .clientId("other-client-id")
                                      .secret("other-client-secret")
                                      .region("test.region");

    delegateContenxt = new AwsPlatformContext(getApplicationContext(), option);
```

`Configuration.Option` 클래스 API
 * `Configuration.Option` 의 속성설정 메소드들은 모두 메소드 체인으로 연결됩니다.

메소드 이름 | 데이터 타입 |  설명
----------|--------------------------|------------------------
clientId    | String or LazyOption\<String> | Client ID 속성을 설정합니다.
secret      | String or LazyOption\<String> | Secret 속성을 설정합니다.
region      | String or LazyOption\<String> | Region 속성을 설정합니다.

> `LazyOption`으로 등록된 속성값들은 해당 속성값이 로드 된 후에 속성값에 접근 할 수 있도록 해줍니다. 네트워크등을 통하여 속성값들을 불러와 설정하는 경우에 유용하게 사용할 수 있습니다.

```java
    Configuration.Option option =
        new Configuration.Option()
            .region(new LazyOption<String>() { 
                @Override public String value() { 
                    // 서버로부터 region값을 로드하는 코드 
                    String region = ..... 
                    return region 
                }
            });
```

##### Configuration LazyInitializer

`Configuration.Option` 이외에도 `Initializer` 인터페이스를 이용해 Client 설정을 지정할 수 있습니다.
특히 `LazyInitializer` 클래스를 이용해 초기화 시점을 지연 및 컨트롤 할 수 있습니다.

`Initializer` 인터페이스 API

메소드 이름 | 설명
------------|----------
public Configuration getConfiguration() | 초기화된 Configuration 객체를 반환
public void init(Configuration.Option option) | Configuration.Option 객체를 이용해 Configuration 을 초기화

###### Application.java
```java
package  net.sample.android.app;
...

class Application extends MultiDexApplication implements PlatformContext {
    private Initializer initializer;
    ...


    public void setConfig(Configuration.Option option) {
        initializer.init(option);
    }

    @Override
    public void onCreate() {
        ...

        initializer = new LazyInitializer(getApplicationContext());
        delegateContext = new AwsPlatformContext(getApplicationContext(), initializer);
    }
}
```

###### TestActivity.java
```java

    @Override
    public void onCreate(Bundle savedInstanceState) {
        ...

        Configuration.Option option = new Configuration.Option()
                                      .clientId("other-client-id")
                                      .secret("other-client-secret")
                                      .region("test.region");

        Application app = (net.sample.android.app.Application)getAppication();
        app.setConfig(option);

    }

```

> :warning: `LazyInitializer` 를 사용해 초기화하는 경우 반드시 `init()` 메소드를 호출해서 초기화를 먼저 시켜야 합니다. 초기화 하지 않을경우 `CLIENT_NOT_INITIALZED` 예외가 발생합니다.

### Application 클래스 등록

초기화 코드를 담고 있는 `Appication` 를 앱이 인식 할 수 있도록 AndroidManifest.xml 파일에 등록해줍니다.

######  AndroidManifest.xml
```xml
<manifest ... >
    <application
        android:name='.Application'
        ... >
    ...
    </application>
</manifest>
```


### API 예외 상황 코드

예외코드 (Platform WEB API code) | 설명
-------|-----
START_API_NOT_CALL | start api 호출 실패
START_API_DATA_FAIL | client process description data 오류
START_API_DATA_INIT | client process description 초기화 실패
PROCESS_CONTRACT_DENIED | 약관 동의 거부
TOKEN_EMPTY | 토큰 없음
TOKEN_CREATION | 토큰 생성 실패
TOKEN_INVALID (session.invalid) | 유효하지 않은 토큰
TOKEN_EXPIRED (session.expired) | 만료된 토큰
CLIENT_NOT_INITIALIZED | 클라이언트 정보가 초기화 되지 않음.
CLIENT_UNKNOWN_PROVIDER (api.provider) | 연계할 수 없는 프로바이더
CLIENT_NOT_REGISTERED (app.none) | 등록되지 않은 클라이언트
API_REQUEST_FAIL | MP API 요청 실패
API_ACCESS_DENIED (auth.forbidden) | API 접근 권한 없음
API_OMITTED_PARAMETER (api.param) | API 파라미터가 누락됨
API_UNSUPPORTED_METHOD (api.method) | 허용되지 않은 메소드로 요청
API_BAD_REQUEST (api.request) | 잘못된 API 요청
API_INCOMPATIBLE_VERSION (api.version) | API 버전 호환 안됨
API_CHARACTER_INFO | 캐릭터 정보 조회 실패
API_UNKNOWN_RESPONSE | API 응답을 변환 할 수 없음
ACCOUNT_NOT_EXIST (account.none) | 계정정보 없음
ACCOUNT_ALREADY_EXIST (account.duplicate) | 이미 등록된 계정임
ACCOUNT_INVALID_PROPERTY (account.value) | 유효하지 않은 계정 속성
ACCOUNT_SYNC_FAIL (account.sync) | 계정연동 실패

### Startup 프로세스 API (배너, 이용약관, 권한)

`EstCommonFramework` 클래스는 앱 시작시 호출할 수 있는 공통 프로세스 기능을 포함하고 있습니다. Activity가 시작될때 객체를 생성하도록 합니다.
아래에 따라오는 모든 코드들은 Activity 클래스 코드 안에서 작성하도록 합니다.


#### 1. `EstCommonFramework` 객체 생성
```java
class StartActivity extends AppCompatActivity {
    EstCommonFramework empFramework;

    ...

    @Override
    public void onCreate(Bundle savedInstanceState) {
        empFramework = new EstCommonFramework(this, new CustomConsumer() {
            @Override
            public void accept(EstcommonFramework ef) {
                // 데이터 설정 후(create() 함수 호출 후) 콜백함수
                // 해당 함수 호출 이후에 화면 호출 함수 호출
            }
        });
        empFramework.create()   //해당 함수 호출 시 StartApi를 호출하여 값을 설정한다. 1.0.5버전에서 수정됨
    }
}
```
해당 객체를 생성할 때 StartApi를 호출하여 값을 구성한다. 해당 호출이 끝나면 initCallBack인터페이스에 run()함수를 호출한다. 데이터가 초기화가 안된 상태에서는 권한, 이용약관, 배너 창이 열리지 않는 다.

#### 2. Application 요구 권한 화면
```java
/**
권한창이 나오는 국가인지 확인하는 함수
*/
Boolean check = empFramework.systemContractShowOrDismiss()

check = true // 권한창이 나오는 국가
check = false // 권한창이 나오지 않는 국가

/**
콜백 함수 설정
*/
empFramework.policyCallBack = new Runnable() {
    @Override
    public void run() {
        if(ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == -1) {
            ActivityCompat.requestPermissions(this
            , arrayOf(Manifest.permission.CAMERA)
            , MY_PERMISSIONS_REQUEST_READ_CONTACTS)
        }
    }
};
empFramework.authorityShow();   //보여주기
```

#### 3. App 이용약관 화면
```java
empFramework.policyCallBack = new Runnable() {
    @Override
    public void run() {
        System.out.println("policyCallBack");
    }
};
empFramework.policyShow();
```

#### 4. 배너 화면
```java
empFramework.bannerCallBack = new Runnable() {  //콜백 함수 적용
    @Override
    public void run() {
        System.out.println("bannerCallBack");
    }
}
empFramework.bannerShow();
```

#### 5. 공지 화면
```java
empFramework.showNotice();
```

#### 6. 고객센터 화면
```java

empFramework.showCSCenter();
```

#### 7. 이벤트 화면
```java

empFramework.showEvent();
```

#### 8. 국가, 언어조회
```java

empFramework.getNation();
empFramework.getLanguage();
```


### 3. 유저 연동 프로세스

#### 1. UserService 객체 생성

```java
public class StartActivity extends AppCompatActivity {
    private UserService uv;

    ...

    @Override
    public void onCreate(Bundle savedInstanceState) {
        uv = new UserSerivce(this);  //객체생성
        //에러 처리 콜백함수
        uv.setFailCallBack(new CustomConsumer<Fail>() {
            @Override
            public void accept(Fail fail) {
                
            }
        });
    }
}
```

#### 2. 게임시작

```java
uv.setStartSuccessCallback(new Runnable() {
    @Override public void run() {
        ...
    }
});
uv.createUser();

//콜백함수
uv.setStartSuccessCallBack(new Runnable() { ... })  //성공시 호출
uv.setFailCallBack(new CustomConsumer<String>() {
    @Override public void accept(String msg) { ... }
 }); //Consumer 인터페이스와 같습니다. sdk버전을 19로 낮추면서 커스텀인터페이스를 하나 만들었습니다.

```

#### 3. SNS 계정 연동

```java
// 뒤로가기 구현을 위해서 추가된 코드
empUserService.setBack(new CustomConsumer<Activity>() {
    @Override
    public void accept(Activity activity) {
        activity.startActivity(new Intent(activity, MRActivity.class));
    }
});

uv.goToLogin();

//핸들러 등록
uv.setLoginResultHandler(new LoginResultHandler() {
    @Override public void onComplete(Result.Login result) { ... };
    @Override public void onFail(Fail code) { ... };
    @Override public void onCancel() { ... };
});
```

SNS 계정 로그인 및 연동에 관한 핸들러를 등록하도록 합니다. `LoginResultHandler` 인터페이스는 다음의 메서드로 구성되어 있습니다.

* public void onComplete(Result.Login result) : 계정연동이 성공한 후 호출 됩니다.
  * Result.Login.getType() : LOGIN(정상적인 로그인) / SWITCH(계정전환) / SYNC(계정연계)
  * Result.Login.getEgID() : 로그인한 사용자의 EGID
  * Result.Login.getProvider() : 로그인한 사용자의 Provider 정보
* public void onFail(Fail code) : SNS 계정연동이 실패했을때 호출 됩니다.
* public void onCancel() : SNS 계정연동을 취소했을 경우 호출 됩니다.

##### 로그인 배경화면 변경

SNS 계정 로그인 화면을 옵션을 이용해 변경 할 수 있습니다. Aws SDK의 `AuthUIConfiguration` 객체를 이용하면 옵션을 지정할 수 있습니다.

```java
        AuthUIConfiguration conf = new AuthUIConfiguration.Builder()
                        .logoResId(R.drawable.logo_aws)
                        .backgroundColor(Color.BLACK)
                        .isBackgroundColorFullScreen(true)
                        .signInButton(FacebookButton.class)
                        .signInButton(GoogleButton.class)
                        .userPools(false)
                        .canCancel(true)
                        .build();

        uv.goToLogin(conf);
```

> 옵션 객체의 설정 메소드는 다음과 같습니다.

메소드 이름 | 값
----------|-----
logoResId   | 로그인 화면의 로고를 설정합니다.
backgroundColor | 배경색을 지정합니다.
isBackgroundColorFullScreen | 배경색을 전체화면으로 적용합니다. 배경색 지정과 함께 설정해야 재대로 적용됩니다.
signInButton | 로그인할 SNS 버튼을 지정합니다.
userPools | AWS Cognito 사용자 풀을 이용한 로그인을 설정합니다. EMP 는 사용자풀을 사용하지 않습니다. false로 설정해주세요
canCanel | 취소 버튼을 설정합니다.

#### 4. 로그아웃

```java
uv.logout();

//콜백함수
uv.setClearSuccessCallBack(new Runnable() { ... }); //로그아웃 후 호출
```

#### 5. 정보 가져오기

```java

// 사용자 정보
Profile profile = uv.getSessionManager().getProfile();

txtStatus.text = profile.getProvider() != null ? session.getProvider() : "guest"
txtUserId.text = "EG ID : " + profile.getEgId();
txtPrincipal.text = "Principal : " + profile.getPrincipal();
txtUserId.text = "UserId : " + profile.getUserId();

// 토큰정보
Token token = uv.getSessionManager().getToken();

txtEgToken.text = "EG Token : " + token.getEgToken();
txtRefreshToken.text = "Refresh Token : " + token.getRefreshToken();
```

### Game Agent

EG 플랫폼과 연동된 게임 서비스의 상태 및 정보를 조회하는 기능을 포함하고 있습니다.

#### 1. GameAgent 객체 생성
```java
    @Overrid
    public void onCreate(Bundle savedInstanceState) {
        GameAgent ag = new GameAgent(this);
    }
}
```

#### 2. Game Server 오픈 여부 조회

GameAgent 객체를 통해 현재 게임 서비스의 open / close 여부를 확인 할 수 있습니다. 이 메서드는 비동기로 동작합니다. 따라서 메소드 호출시 핸들러를 필요로 합니다.

```java
    GameAgent ga = new GameAgent(...);

    ...

    ga.retrieveStatus(new GameAgent.StatusReceiver() {
        @Override
        public void onReceived(boolean isServiceOn) {
            // isServiceOn == true 이면 서비스가 오픈된 상태 아니면 닫힌 상태입니다.
            // 클라이언트 코드 작성
        }

        @Override
        public void onFail(Fail code) {
            // 상태 조회시 오류가 발생한 경우
        }
    });

```

##### `GameAgent.StatusReceiver` 인터페이스

게임 서비스 상태 요청에 대한 응답 받는 핸들러 인터페이스입니다. 메소드는 다음과 같습니다.

* public void onReceived(boolean isServiceOn) : 서버로부터 확인 응답이 왔을 경우 호출됩니다.
  * isServiceOn  이 `true` 인 경우 서비스가 오픈된 상태입니다.
* public void onFail(Fail code) : 서버로부터 정상적인 응답을 받지 못 했을 경우 호출됩니다. 응답 코드는 다음과 같습니다.

코드 | 설명
----|------
API_BAD_REQUEST | 클라이언트가 잘못된 요청을 보낸경우. 예) 잘못된 region값으로 호출 등
API_UNKNOWN_RESPONSE | 서버로부터 정상적인 응답값을 받지 못한 경우.
API_REQUEST_FAIL | 서버 API 호출 실패



