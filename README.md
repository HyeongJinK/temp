# estgames-common-framework (이스트 게임즈 아이폰 공통 라이브러리)

## :page_with_curl: Android App 프로젝트 설정

### 라이브러리 import
안드로이드 프로젝트는 기본적으로 gradle을 기반으로 프로젝트를 구성합니다.
EGMP SDK를 사용하기 위해 build.gradle 파일에 의존성 정보를 등록합니다.

###### build.gradle
```gradle
....
dependencies {
    implementaion 'com.estgames.estgames_framework:app-release2:1.0@aar'
    ...
}
```

:warning: 현재 EGMP 플랫폼에서는 라이브러리 저장소를 제공하지 않습니다.
**app-release2.aar** 파일을 다운로드 받아 import 할 경우 로컬 repository를 설정해주세요.
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
