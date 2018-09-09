# AndroidManifest.xml 설정

안드로이드 앱에서 MP SDK 의 라이브러리를 사용하기 위해서는 안드로이드의 Manifest.xml 파일에 몇가지 설정이 추가 되어야 합니다.


## package name 설정

사용자 계정을 외부 OPEN ID 서비스의 계정을 사용하여 연동할 경우 각 프로바이더들의 클라이언트 설정에 package name 을 필요로 합니다.
IDE 툴을 사용하여 프로젝트를 생성했을 경우 package name 을 수정할 필요는 없습니다.

⚠ 일부 OPEN ID 서비스의 경우 (google+) package name 정보가 일치하지 않는 경우 계정 연동에 실패합니다.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android" pacakage="net.sample.android.app">
    ...
</manifest>
```

## uses-permission 설정

EGMP 서비스들은 모두 웹 기반의 API 입니다. 따라서 모바일 앱에서 인터넷 및 네트워크 관련 권한설정을 해야 합니다.

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

## Facebook 로그인 설정 (Option)

Android App 에서 Facebook 계정으로 로그인 연동을 하는 경우 Manefest.xml 파일에 페이스북 관련 설정을 해야합니다.
페이스북 로그인은 페이스북 로그인 창을 위한 Activity 등록과 페이스북 앱 인증을 위한 meta-data 설정이 필요합니다.
facebook app id 등의 리소스를 분리할 경우 res/values/string.xml 파일에 리소스를 등록해줍니다.

### Facebook Login Activity 등록

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

### Facebook meta-data 설정

```xml
<manifest ... >
    <application ...>
        <meta-data
            android:name="com.facebook.sdk.ApplicationId"
            android:value="@string/facebook_app_id" />
    </application>
</manifest>
```

### Facebook 설정을 위한 리소스 등록 (res/values/string.xml)

fb_login_protocol_scheme 값은 fb + [facebook_app_id] 형태로 입력해주시면 됩니다.

> 예) fb1234567893456

```xml
<resource>
    <string name="facebook_app_id">[facebook_app_id]</string>
    <string name="fb_login_protocol_scheme">fb[facebook_app_id]</string>
</resource>
```
