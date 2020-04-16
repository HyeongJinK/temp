# PlatformContext 구성

EGMP 서비스를 이용하기 위해 MP Configuration을 초기화 하고 Context를 구성하도록 합니다.
Application 클래스를 MP Context로 인식 할 수 있도록 PlatformContextContainer 인터페이스를 구현합니다.

## Application 클래스 추가

##### Application.java

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

## Application 클래스 등록

초기화 코드를 담고 있는 Appication 를 앱이 인식 할 수 있도록 AndroidManifest.xml 파일에 등록해줍니다.

##### AndroidManifest.xml

```xml
<manifest ... >
    <application
        android:name='.Application'
        ... >
    ...
    </application>
</manifest>
```

## Configuration 설정하기

`ConfigurationScript` 인터페이스를 이용해 앱 설정값을 작성 할 수 있습니다. 이 인터페이스를 이용하면 `egconfiguration.json` 설정 파일없이 순수하게 자바 코드만으로 어플리케이션 설정을 구성할 수 있습니다.

```java
    class SampleScript implements ConfigurationScript {
        @Override
        public void script(Configuration config) {
            config
                .app()
                    .region("sample.region.code")
                    .clientId("sample-client-id")
                    .secret("sample-app-secret")
                    .end()
                .account()
                    .guest().identityGenerator(DeviceUserIdentityGenerator.class)
                    .facebook().scopes("public_profile, email");
        }
    }
```

> configuraion 을 구성하는 각 섹션 설정 스크립트는 `end()` 메소드로 종료할 수 있습니다.

## App (client) 설정

`Configuration` 객체의 `app()` Descriptor 를 이용하면 클라이언트 설정을 작성 할 수 있습니다. App 설정은 `ClientID`, `Secret`, `Region` 으로 구성됩니다.

```java
public void script(Configuration config) {
    config
        .app()
            .region("region-code")              // Region 코드 설정
            .clientId("app-client-id-value")    // client id 설정
            .secret("app-secret-value");        // app secret 설정
}
```

## Account 설정

`Configuration` 객체의 `account()` Descriptor 를 이용하면 사용자 계정 설정을 작성 할 수 있습니다. Account 설정은 게스트, SNS 프로바이더 설정으로 구성됩니다.

```java
public void script(Configuration config) {
    config
        .account()
            .guest().identityGenerator(InstantUserIdentityGenerator.class)
            .google().scopes("email, profile, openid")
            .facebook().scopes("public_profile", "email");
}
```

* `guest()` - 게스트 계정관련 설정을 작성합니다.
  * identityGenerator : [게스트 계정 식별자 생성기](_draft/session/Guest.md)를 설정합니다. 기본값은 DeviceUserIdentityGenerator.class 입니다.

* `google()`, `facebook()` - SNS 계정 프로바이더 설정을 작성합니다.
  * scopes : SNS 계정 연동시 요청할 퍼미션 정보를 설정합니다.

## Java Code Configuration 예제

다음은 ConfigurationScript 인터페이스를 이용해 어플리케이션 설정을 작성하는 예제 `Application` 클래스입니다.

```java
class Application extends MultiDexApplication implements PlatformContextContainer, ConfigurationScript {
    private GenericPlatformContext delegateContext;

    @Override
    public void onCreate() {
        super.onCreate();
        delegateContext = new GenericPlatformContext(getApplicationContext());
        // Configuration Script를 PlatformInitializer에 적용합니다.
        // GenericPlatformContext 클래스는 PlatformInitializer 인터페이스를 구현하고 있습니다.
        // PlatformContext 객체는 EgClient 를 통해 Context 를 얻어올때 초기화가 됩니다.
        delegateContext.configuration(this);
    }

    @NotNull @Override
    public PlatformContext getContext() {
        return delegateContext;
    }

    /**
     * Configuration Script 를 작성합니다.
     **/
    @Override
    public void script(Configuration config) {
        config
            .app()
                .region("sample.global.stage")
                .clientId("sample-client-id.sample.estgames.com")
                .secret("sample-app-secret-code")
                .end()
            .account()
                .guest().identityGenerator(DeviceUserIdentityGenerator.class)
                .facebook).scopes("public_profile, email")
                .google().scopes("email", "profile", "openid");

    }
}
```