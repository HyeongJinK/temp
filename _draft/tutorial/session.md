# 플랫폼 세션 연동하기

이 튜토리얼 문서는 EG 플랫폼을 빠르게 계정연동을 하기 위한 기본적인 설정 방법을 설명하고 있습니다. 좀 더 자세한 내용은 [플랫폼 계정 연동 문서](/_draft/session/init.md)를 참조하기 바랍니다. 
이 튜토리얼 문서는 사용자의 명시적인 로그인을 통해 세션을 생성한다고 가정하고 진행합니다.

## 세션 매니저 생성

`SessoinManager` 는 EG 플랫폼의 세션 제어를 담당하는 클래스 입니다. 세션을 생성하고 갱신, 조회, 삭제 하기 위해서는 세션매니저를 생성해야 합니다. `SessionManager`는 EgClient 를 통해 생성할 수 있습니다.

```java
    SessionManager sessionManager = Client.from(context).getSessionManager();
```

## Guest 세션 생성하기 (Guest 사용자 로그인하기)

EG 플랫폼에서 Guest 사용자는 SNS 인증을 거치지 않은 비로그인 세션입니다. Guest 세션은 SNS 사용자와 연동을 거치지 않기 때문에 세션 만들기로 바로 생성할 수 있습니다. 

⚠ 주의 : 이전에 생성된 세션이 있는경우 호출하면 세션 중복생성 에러를 던지게 됩니다.

```java
if (!sessionManager.isSessionOpen) {
    sessionManager.crate()
            .onError(new Task.Acceptor<Throwable>() {
                @Override
                public void accept(Throwable t) {
                    // 세션 생성 실패 핸들러 작성
                }
            })
            .asyncAccept(new Task.Acceptor<String>() {
                @Override
                public void accept(String token) {
                    // 세션 생성 성공 핸들러 작성
                }
            });
}
```

## 세션 토큰 조회

`SessionManager` 를 통해 현재 세션의 토큰 정보를 조회 할 수 있습니다. 세션이 열려있지 않은경우 `null`을 반환합니다.

```java
    Token token = sessionManager.getToken();

    String egToken = token.getEgToken();
    String refToken = token.getRefreshToken();
```

## 사용자 Profile 조회

`SessionManager` 를 통해 현새 세션의 사용자 Profile 정보를 조회 할 수 있습니다. 세션이 열려있지 않은경우 `null`을 반환합니다. 

```java
    Profile profile = sessionManager.getProfile();

    String egId = profile.getEgId();
    String userId = profile.getUserId();
    String email = profile.getEmail();
    String provider = profile.getProvider();
```

## 세션 재시작하기

EG 플랫폼의 세션 토큰은 만료시간을 가지고 있습니다. 따라서 앱을 다시 시작했을 경우 유효한 세션을 만들기 위해 앱을 시작할때 마다 세션을 재시작 해야 합니다.

```java
if (sessionManager.isSessionOpen) {
    sessionManager.resume()
            .onError(new Task.Acceptor<Throwable>() {
                @Override
                public void accept(Throwable t) {
                    // 세션 갱신 실패 핸들러 작성
                }
            })
            .asyncAccept(new Task.Acceptor<String>() {
                @Override
                public void accept(String token) {
                    // 세션 갱신 성공 핸들러 작성
                }
            });
}
```

## 세션 종료(로그아웃)하기

`SessionManager`를 이용하여 현재 발행된 세션을 종료 할 수 있습니다. 세션을 종료하면 토큰을 만료하고 사용자 연결을 끊습니다. (SNS 로그인이 되어 있다면 SNS 연결도 로그아웃 시킵니다.)

```java
    sessionManager.signOut()
            .onError(new Task.Acceptor(Throwable t) {
                // 세션 종료 실패 핸들러 작성
            })
            .asyncAccept(new Task.Acceptor() {
                // 세션 종료 핸들러 작성
            })
```

## 외부 프로바이더 사용자 연동하기