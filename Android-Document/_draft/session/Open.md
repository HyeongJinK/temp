# 세션 생성(게스트 로그인) 및 세션 갱신

## 세션의 시작

앱의 사용자 세션의 시작은 이전 세션의 존재 여부를 판단하는 것으로부터 시작할 수 있습니다.
앱을 시작했을 때 세션이 없을 경우에는 create() 메소드를 사용하여 게스트 계정을 만들 수 있고 기존 세션이 있는 상태라면(SNS계정 포함) 세션을 다시 사용하기 위해 갱신할 수 있습니다.

```java
    // 앱 클라이언트에 생성된 세션이 있는지 여부를 확인합니다.
    // isSessionOpen()의 반환값은 세션의 유효성 여부와는 상관 없습니다.
    if(sessionManager.isSessionOpen()) {
        // 이전 세션 갱신
        resumeSession();
    } else {
        // 게스트 세션 생성
        createGuestSession();
    }
```

앱의 시작과 동시에 세션을 생성할 것인지 아니면 사용자가 의사를 확인 후 세션을 생성할 것인지는 앱 서비스의 정책에 따르면됩니다.

> 주의할점은 앱에 생성된 세션이 있는 경우 기존 세션을 사용하기 위해서는 세션을 사용하기 전에 ___세션 갱신___(`resume()`)을 꼭 해야 합니다.

## 새로운 세션의 생성

EG 플랫폼은 게스트 계정의 세션 생성을 지원합니다. 게스트 계정은 인증되지 않은 사용자 계정을 의미합니다.
게스트 계정은 플랫폼 SDK의 옵션에 따라 [휘발성 계정으로 생성](/_draft/session/Guest.md)할지 [기기 또는 앱별 고유 계정으로 생성](/_draft/session/Guest.md)할지 선택 할 수 있습니다.

> 이 단락은 게스트 세션의 생성만을 다루고 있습니다. SNS계정 로그인 및 연동은 [SNS 계정연동](/_draft/session/Sns.md) 부분을 참고하세요.

### _SessionManager.create()_

`SessionManager` 객체의 `create()` 메소드로 새로운 게스트 세션을 생성할 수 있습니다. 이 메소드는 [Task](/_draft/core/Task.md) 객체를 리턴합니다. [Task](/_draft/core/Task.md)는 메소드 체인을 이용한 Fluent 인터페이스를 제공합니다.

* Parameter : 없음
* Return _`Task<String>`_ : Task 객체가 콜백에 전달하는 값은 새로 생성된 세션의 EG_TOKEN 값입니다.

```java
sessionManager
    .create()
    .onError(new Task.Acceptor<EGException>() {
        @Override
        public void accept(EGException e) {
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

## 이전 세션의 재시작

EG 플랫폼의 앱 세션은 종류에 상관 없이 유효기간을 가지고 있습니다.
앱이 유효기간이 지난 세션으로 플랫폼 서비스에 접근할 경우 플랫폼은 서비스의 접근을 제한합니다.
따라서 앱이 정상적으로 플랫폼 서비스를 사용하기 위해서는 세션정보를 항상 유효하게 유지 시켜야 합니다.

EG 플랫폼에서는 세션을 유효하게 유지 하기 위해 새로운 세션을 항상 만들 필요는 없습니다. 만약 이전에 사용자가 로그인 한 적이 있다면 앱은 그 사용자의 세션을 갱신하여 활성화 시킬 수 있습니다.

### _SessionManager.resume()_

`SessionManager`객체의 `resume()` 메소드로 이미 존재하는 세션을 갱신 할 수 있습니다.

* Parameter : 없음
* Return _`Task<String>`_ : Task 객체가 콜백에 전달하는 값은 갱신된 세션의 EG_TOKEN 값입니다.

```java
sessionManager
    .resume()
    .onError(new Task.Acceptor<EGException>() {
        @Override
        public void accept(EGException e) {
            currentTitle.setText("세션 갱신 실패 = " + e.getMessage());
        }
    })
    .asyncAccept(new Task.Acceptor<String>() {
        @Override
        public void accept(String token) {
            currentTitle.setText("세션 갱신 성공 = " + token);
        }
    });
```