# 세션, 유저정보 조회하기

`SessionManager`객체는 현재 앱 세션의 상태정보 및 계정정보를 조회하는 기능을 제공하고 있습니다.
세션 매니저로 확인 할 수 있는 정보는 현재 세션의 Token, 현재 사용자의 Profile, 및 현재 세션의 유효성등 입니다.

## _SessionManager.isSessionOpen()_

* Parameter : 없음
* Return _`boolean`_ : 앱에 생성된 세션이 존재하는지 여부

이 메소드는 현재 앱 클라이언트에 사용할 수 있는 세션이 있는지 여부를 판단해줍니다.
그러나 이 메소드로 앱에 존재하는 세션이 유효한지 여부는 확인할 수 없습니다.

> 앱 시작시 존재하는 세션을 항상 갱신시켜주면 세션의 유효성을 보장 할 수 있습니다.

## _SessionManager.getToken()_

* Parameter : 없음
* Return _`Token`_ : 현재 세션의 토큰 정보
* 토큰이 없으면 null 반환

현재 세션의 토큰 정보를 반환합니다. `Token` 객체는 EG 플랫폼 서비스에 접속을 하기위한 토큰 정보들을 포함하는 객체입니다.

### _Token_ (인터페이스)

`Token` 은 세션 토큰 정보를 표현하는 인터페이스입니다. 인터페이스는 다음 메소드들을 가지고 있습니다.

#### _getEgToken()_

* EG_TOKEN
* 데이터 타입 : String
* EG 플랫폼 서비스 접근을 위한 Access token 문자열

#### _getRereshToken()_

* REFRESH_TOKEN
* 데이터 타입 : String
* EG_TOKEN 갱신을 위한 보안 및 인증 token 문자열

## _SessionManager.getProfile()_

* Parameter : 없음
* Return _`Profile`_ : 현재 세션의 사용자 프로파일
* 프로파일이 없으면 null 반환

현재 세션의 사용자 프로파일 정보를 반환합니다. `Profile` 객체는 EG_ID, 사용자 아이디, 이메일등의 정보를 포함합니다.

### _Profile_ (인터페이스)

`Profile`은 사용자 프로파일을 표현하는 데이터 인터페이스 입니다. 인터페이스는 다음 메소드들을 가지고 있습니다.

#### _getEgId()_

* EG_ID
* 데이터 타입: String
* EG 플랫폼 사용자 계정 아이디

#### _getUserId()_

* USER_ID
* 데이터 타입: String
* EG_ID 와 연결된 사용자 ID. 사용자에게 실제 노출되는 10자리 문자열 아이디.

#### _getProvider()_

* SNS 계정 프로바이더
* 데이터 타입: String (null 허용)
* 계정 프로바이더 정보. null 일경우 연결된 SNS계정 없음. (=Guest 계정)

#### _getEmail()_

* E-mail
* 데이터 타입: String (null 허용)

#### _getPrincipal()_

* PRINCIAPL
* 데이터 타입: String
* Provider 계정 식별자.