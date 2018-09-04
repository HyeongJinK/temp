# PlatformContext 구성

EGMP 서비스를 이용하기 위해 MP Configuration을 초기화 하고 Context를 구성하도록 합니다.
Application 클래스를 MP Context로 인식 할 수 있도록 PlatformContext 인터페이스를 구현합니다.


## Application 클래스 추가

##### Application.java
```java
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

## Configuration 속성 관리

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

## Configuration LazyInitializer

`Configuration.Option` 이외에도 `Initializer` 인터페이스를 이용해 Client 설정을 지정할 수 있습니다.
특히 `LazyInitializer` 클래스를 이용해 초기화 시점을 지연 및 컨트롤 할 수 있습니다.

`Initializer` 인터페이스 API

메소드 이름 | 설명
------------|----------
public Configuration getConfiguration() | 초기화된 Configuration 객체를 반환
public void init(Configuration.Option option) | Configuration.Option 객체를 이용해 Configuration 을 초기화