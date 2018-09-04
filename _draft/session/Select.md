# 세션, 유저정보 조회하기

SessionManager에서 getToken() 메소드로 현재 세션의 토큰 정보를 조회할 수 있으며 getProfile() 메소드로 프로필 정보를 조회할 수 있습니다.


### SessionManager 세션정보 조회관련 메소드

|함수명|리턴타입|설명|
|-|-|-|
|getToken|com.estgames.framework.session.Token|토큰정보|
|getProfile|com.estgames.framework.session.Profile|유저관련 정보|

### Token

|함수명|리턴타입|설명|
|-|-|-|
|getEgToken|String|EgToken|
|getRefreshToken|String|RefreshToken|

### Profile

|함수명|리턴값|설명|
|-|-|-|
|getEgId|String|EgId|
|getUserId|String|유저아이디|
|getProvider|String?|프로바이더(gmail,facebook)|
|getEmail|String?|이메일|
|getPrincipal|String|Principal|

##### 예)
```java
Token token = client.getSessionManager().getToken(); // 현재 세션의 토큰정보 조회
Profile profile = client.getSessionManager().getProfile(); // 현재 세션의 프로필정보 조회하기

if (token != null) {
    egTokenTitle.setText("getEgToken = " + token.getEgToken());
    refreshTokenTitle.setText("getRefreshToken = " + token.getRefreshToken());
}

if (profile != null) {
    egIdTitle.setText("getEgId = " + profile.getEgId());
    emailTitle.setText("getEmail = " + profile.getEmail());
    pricipalTitle.setText("getPrincipal = " + profile.getPrincipal());
    providerTitle.setText("getProvider = " + profile.getProvider());
    userIdTitle.setText("getUserId = " + profile.getUserId());
}
```