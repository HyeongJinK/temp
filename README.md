# estgames-common-framework (이스트 게임즈 안드로이드 공통 라이브러리)

## 업데이트 사항

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

#### 4. 공지 화면
```java
empFramework.showNotice();
```

#### 4. 고객센터 화면
```java

empFramework.showCSCenter();
```


### 3. 유저 연동 프로세스

#### 1. UserService 객체 생성

```java
public class StartActivity extends AppCompatActivity {
    private UserService uv;

    ...

    @Override
    public void onCreate(Bundle savedInstanceState) {
        uv = new UserSerivce(this, this.getApplicationContext());  //객체생성
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
uv.setStartFailCallBack(new CustomConsumer<String>() {
    @Override public void accept(String msg) { ... }
 }); //Consumer 인터페이스와 같습니다. sdk버전을 19로 낮추면서 커스텀인터페이스를 하나 만들었습니다.

```

#### 3. SNS 계정 연동

```java
//팝업창에 텍스트 설정 초기화하지 않으면 아래 텍스트가 기본으로 들어간다. 국가별, 계정별 게임데이터 정보 출력에 따라 수정이 필요하다.
uv.setUserLinkMiddleText = new CustormSupplier<String>() {
    @Override
    public String get() {
        return "입력하신 계정에 이미 플레이 중인 데이터가 있습니다.\nFacebookAccount: []\n위의 데이터를 불러오시겠습니까?";
    }
};
uv.setUserLinkBottomText = new CustormSupplier<String>() {
    @Override
    public String get() {
        return "!현재 플레이 중인 게임데이터([])는 삭제됩니다";
    }
};

uv.setUserLoadText = new CustormSupplier<String>() {
    @Override
    public String get() {
        return "현재 게스트 모드로 플레이 중인 데이터([])를\n삭제하고 기존 데이터를 불러오시려면 아래 문자를 입력해주세요";
    }
};
    
uv.setUserGuestText = new CustormSupplier<String>() {
    @Override
    public String get() {
        return "기존 연동된 데이터 ([])를 삭제하고 현재 플레이중인 게임 데이터로 계정연동을 진행합니다.\n[]";
    }
};

uv.goToLogin();

// 콜백함수

uv.setGoToLoginSuccessCallBack(new Runnable() { ... });  //성공시 호출
uv.setGoToLoginFailCallBack(new CustomConsumer<String>() {
    @Override public void accept(String msg) { ... }
}) //실패시 호출
```

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

// 토큰정보
Token token = uv.getSessionManager().getToken();

txtEgToken.text = "EG Token : " + token.getEgToken();
txtRefreshToken.text = "Refresh Token : " + token.getRefreshToken();
```
               