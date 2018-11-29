# App 설정하기

이 튜토리얼 문서는 EG 플랫폼을 빠르게 연동하기 위한 기본적인 설정 방법을 설명하고 있습니다. 좀 더 자세한 내용은 [라이브러리 설정 문서](/_draft/setting/init.md)를 참조하기 바랍니다.
이 튜토리얼 문서는 안드로이드 프로젝트가 Gradle로 구성되어 있다고 가정하고 진행합니다. 다른 빌드 환경을 사용하는 경우는 해당 환경에 맞춰서 의존성 트리를 구성해주세요.

## bulid.gradle 설정

1. EG 플랫폼 SDK for Android 라이브러리 등록.
* 다운로드 받은 `mp-aos-release.aar` 파일을 프로젝트 라이브러리 디렉토리(`libs`)에 복사합니다.
* `gradle`에서 라이브러리를 감지 할 수 있도록 `repositories` 설정을 추가합니다.

```gradle
repositories {
    flatDir {
        dirs 'libs'
    }
}
```

2. 의존 라이브러리 설정 
* 프로젝트가 필요로 하는 라이브러리를 등록합니다.

```gradle
dependencies {
    implementation 'org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.+'
    implementation 'com.android.support:multidex:1.0.1'
    implementation 'com.android.support.constraint:constraint-layout:1.1.2'
    implementation 'com.google.android.gms:play-services-auth:15.0.1'
    implementation 'com.facebook.android:facebook-login:[4, 5)'
    implementation 'com.estgames.framework:mp-aos-sdk-release:2.0@aar'
}
```

## raw 디렉토리에 플랫폼 설정정보 등록

EG 플랫폼 연동을 위해 등록한 Application 연동 설정 파일을(`egconfigration.json`) 프로젝트의 `res/raw` 디렉토리에 저장합니다. 

```json
# res/raw/egconfiguration.json

{
  "Client" : {
    "ClientId": "0eae170b-ec59-3f85-bfda-a8c80fc1a3fe.mp.estgames.com",
    "Secret": "13949b24f1fd9d3c81aabd11295c28507ee0a977e9dc5dc93a3bea86f8243b46",
    "Region": "cm.global.stage"
  },

  "Account": {
    "Google": {
      "Permissions": "email, profile, openid"
    },
    "Facebook": {
      "Permissions": "public_profile, email"
    }
  }
}
```

## Application 클래스 작성

App 전역에서 플랫폼 Context 참조를 위한 Application 클래스를 작성합니다. 작성 위치는 App의 root package 입니다.

```java
public class Application extends MultiDexApplication implements PlatformContextContainer {
    private PlatformContext delegateContext;

    @Override
    public PlatformContext getContext() {
        return delegateContext;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        this.delegateContext = new GenericPlatformContext(getApplicationContext());
    }
}
```

## AndroidManifest.xml 파일 작성

1. package name 확인
* SNS 연동을 하는 경우 SNS 프로바이더의 App 또는 Application 에 등록한 패키지 명이 맞지 않을 경우 로그인 인증이 거부 됩니다. 등록한 패키지 명이 맞는지 반드시 확인하세요.
* 프로젝트 구성 패키지와 외부 노출 패키지가 다른경우 `gradle` 설정에서 [외부 노출 패키지명을 설정](/_draft/setting/gradle.md) 할 수 있습니다.

```xml
<manifest 
    xmlns:android="http://schemas.android.com/apk/res/android" 
    pacakage="net.sample.android.app">

```

2. uses-permission 설정

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

3. application context 클래스 등록
* 위에서 플랫폼 참조를 위해 작성한 Application 클래스를 `AndroidManifest.xml` 파일에 등록합니다.

```xml
<application android:name=".Application" ...>
```