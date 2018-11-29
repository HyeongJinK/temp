# 세션 생성(게스트 로그인) 및 세션 갱신

세션 생성은 <span style="color:red">create()</span> 메소드로 만드며 해당 메소드는 Task 클래스를 리턴합니다. Task는 빌더 패턴을 이용하여 로그인이 끝난 이후 혹은 에러 시 처리를 구현합니다.

앱을 시작했을 때 세션이 없을 경우에는 create() 메소드를 사용하여 게스트 계정을 만들 수 있고 현재 세션이 있는 상태라면(SNS계정 포함) 세션을 다시 사용하기 위해 갱신을 해주어야 합니다. 갱신은 <span style="color:red">resume()</span> 메소드를 호출하여 토큰을 갱신할 수 있습니다.

Task에서 제공하는 메소드에서는 하나의 함수를 구현하는 인터페이스인 Acceptor를 매개변수로 받습니다.

## Task에서 제공하는 메소드

|함수명|설명|리턴값|매개변수|
|-|-|-|-|
|asyncAccept|정상종료 이후 처리|com.estgames.framework.core.Task|Acceptor&lt;T>|
|onError|에러시 처리 구현|com.estgames.framework.session.Token|Acceptor&lt;T>|

##### 예) 게스트 세션생성 및 생성 이후, 실패 시 처리

```java
sessionManager
    .create()
    .onError(new Task.Acceptor<Throwable>() {
        @Override
        public void accept(Throwable t) {
            // 세션 생성 실패 핸들러 작성
        }
    })
    .asyncAccept(new Task.Acceptor<String>() {
        @Override
        public void accept(String token) {
            // 세션 생성 완료 핸들러 작성
        }
    });
```

##### 예) 세션 갱신

```java
sessionManager
    .resume()
    .onError(new Task.Acceptor<Throwable>() {
        @Override
        public void accept(Throwable throwable) {
            currentTitle.setText("세션 resume 실패 = " + throwable.getMessage());
        }
    })
    .asyncAccept(new Task.Acceptor<String>() {
        @Override
        public void accept(String s) {
            currentTitle.setText("세션 resume 성공 = " + s);
        }
    });
```