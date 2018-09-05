# 세션 매니져 생성

EgClient의 `getSessionManager()` 메소드를 사용하여 `SessionManager`을 생성합니다. `SessionManager`에서는 다음과 같은 일을 합니다.

* 게스트 로그인
* 세션, 유저정보 조회
* 로그아웃

```java
final SessionManager sessionManager = client.getSessionManager();
```

## SessionManger에서 제공하는 메소드

|함수명|설명|리턴값|매개변수|
|-|-|-|-|
|isSessionOpen|세션유무 확인|boolean|없음|
|open|게스트 생성, 계정이 있을 경우는 토큰 갱신|com.estgames.framework.core.Task|없음|
|create|게스트 계정 생성|com.estgames.framework.core.Task|없음|
|resume|토큰 갱신|com.estgames.framework.core.Task|없음|
|getToken|토큰정보|com.estgames.framework.session.Token|없음|
|getProfile|유저관련 정보|com.estgames.framework.session.Profile|없음|
|signOut|로그아웃|com.estgames.framework.core.Task|없음|