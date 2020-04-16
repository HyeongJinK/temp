# 세션 매니져 생성

EgClient의 `getSessionManager()` 메소드를 사용하여 `SessionManager`을 생성합니다. `SessionManager` EG 플랫폼의 세션 및 토큰의 제어 및 조회 기능을 담당합니다.

* 세션 생성. (게스트 세션 생성)
* 세션, 유저정보 조회
* 로그아웃

```java
final SessionManager sessionManager = client.getSessionManager();
```

## 세션 확인 메소드

|함수명|리턴값|설명|
|-|-|-|
|isSessionOpen|boolean|세션의 만료 여부와는 상관없이 생성된 세션 (발급된 토큰)이 있으면 True를 반환합니다.|
|getToken|Token|토큰정보를 반환합니다.|
|getProfile|Profile|사용자 프로필 정보를 반환합니다.|

## 세션 제어 메소드

App Client 의 세션의 상태를 변경 및 유지 하는 기능을 하는 메소드들이 포함됩니다. 세션 제어 메소드들은 동기 / 비동기 방식으로 호출이 가능합니다. 

### 비동기방식 호출

비동기 방식으로 메소드를 호출 하는경우 모든 제어 메소드들은 [`Task`](/_draft/core/Task.md) 객체를 반환합니다.

```java
    Task<String> task = sessionManager.resume();
```

|함수명|설명|리턴값|매개변수|
|-|-|-|-|
|open|게스트 생성, 계정이 있을 경우는 토큰 갱신|Task&lt;String>|없음|
|create|게스트 계정 생성|Task&lt;String>|없음|
|resume|토큰 갱신|Task&lt;String>|없음|
|sync|세션 동기화|Task&lt;Result>|data: Map<String, Object>|
|expire|세션 토큰 만료|Task&lt;Unit>|없음|
|signOut|로그아웃|Task&lt;Unit>|없음|

### 동기방식 호출

동기 방식으로 제어 메소드들을 호출 하기위해서는 `SessionManager` 객체의 `await` 객체를 사용합니다.

```java
    String token = sessionManager.await.resume();
```

|함수명|설명|리턴값|매개변수|
|-|-|-|-|
|open|게스트 생성, 계정이 있을 경우는 토큰 갱신|String|없음|
|create|게스트 계정 생성|String|없음|
|resume|토큰 갱신|String|없음|
|sync|세션 동기화|Result|data: Map<String, Object>|
|expire|세션 토큰 만료|없음|없음|
|signOut|로그아웃|없음|없음|