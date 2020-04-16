# EG 플랫폼 API 예외

EG 플랫폼 API 여러 상황별 예외 코드를 정의하고 있으며, 예외가 발생하면 예외 코드가 포함된 `EGException` 예외 객체를 클라이언트에 넘겨줍니다.

## EGException

EG 플랫폼 SDK (for 안드로이드)의 API 들은 예외상황이 발생하면 클라이언트에 `EGException`을 돌려줍니다. 이 `EGException` 객체는 예외가 발생한 원인을 지시하는 `Fail` 코드를 포함하고 있습니다. 이 `Fail` 예외코드를 통해 예외 상황을 확인하고 제어 할 수 있습니다.

**예외 샘플 코드**

```java
    // 세션 생성 실패 sample code
    sessionManager.create()
        .onError(new Task.Accept<EGException>() {
            @Override
            public void accept(EGException e) {
                if (Fail.TOKEN_CREATION == e.getCode()) {
                    // eg token 생성이 실패한 경우.
                }
            }
        })
        .asyncAccept(new Task.Acceptor<String>() {
            ...
        });
```

## Fail 코드

`Fail`은 EG 플랫폼 SDK에서 발생 할 수 있는 예외 코드들을 정의한 ___enum___ 객체입니다. 예외 코드들은 `EGException` 이 발생할때 예외 객체들에 함께 포함됩니다.

예외 코드들은 여러 유형들로 구분이 됩니다. 예외 유형들은 아래 문서를 참고하세요.

## Client

클라이언트의 SDK 설정 및 Context 관련된 예외코드를 정의합니다. 이 유형의 예외 코드들은 ***CLIENT_*** 로 시작합니다.

|예외코드| API Code | 설명 |
|-|-|-|
|CLIENT_NOT_INITIALIZED||클라이언트의 SDK Context가 초기화 되지 않음.|
|CLIENT_ALREADY_INITIALIZED||클라이언트의 SDK Context가 이미 초기화 됨.|
|CLIENT_INITIALIZING_FAIL||클라이언트의 SDK Context 초기화가 실패함.|
|CLIENT_UNKNOWN_PROVIDER|api.provider|지원하지 않는 SNS 프로바이더입니다.|
|CLIENT_NOT_REGISTERED|app.none| 등록되지 않은 클라이언트 정보입니다.|

## 플랫폼 API

EG 플랫폼이 서비스 하는 Open API 호출에 실패 했을때 발생하는 예외코드를 정의합니다. 이 유형의 예외 코드들은 ***API_*** 로 시작합니다.

|예외코드| API Code | 설명 |
|-|-|-|
|API_REQUEST_FAIL||MP API 요청 실패함.|
|API_ACCESS_DENIED|auth.forbidden|API 접근 거부됨.|
|API_OMITTED_PARAMETER|api.param|API 파라미터가 누락됨.|
|API_UNSUPPORTED_METHOD|api.method|허용되지 않은 메소드로 요청.|
|API_BAD_REQUEST|api.request|잘못된 API 요청.|
|API_INCOMPATIBLE_VERSION|api.version|API 버전 호환 안됨.|
|API_CHARACTER_INFO||캐릭터 정보 조회 실패.|
|API_UNKNOWN_RESPONSE||API 서버로부터 예상되지 않은 응답이 왔을 경우에 발생합니다. 대부분 API 서버에 문제가 있을때 발생합니다.|

## 세션 및 토큰

EG 플랫폼의 세션 및 세션 토큰과 관련된 예외코드를 정의합니다. 이 유형의 예외 코드들은 ***TOKEN_*** 으로 시작합니다.

|예외코드| API Code | 설명 |
|-|-|-|
|TOKEN_EMPTY||생성된 토큰이 없음. 기존에 생성된 세션이 없는 상황입니다.|
|TOKEN_CREATION||토큰 생성 실패.|
|TOKEN_INVALID|session.invalid|유효하지 않은 토큰.|
|TOKEN_EXPIRED|session.expired|만료된 토큰. 세션이 만료된 상황입니다.|
|TOKEN_REVOKED|session.revoked|폐기된 토큰. 세션을 새로 생성해야 합니다.|

## EG 계정

EG 플랫폼의 계정과 관련된 예외코드를 정의합니다. 이 유형의 예외 코드들은 ***ACCOUNT_*** 로 시작합니다.

|예외코드| API Code | 설명 |
|-|-|-|
|ACCOUNT_NOT_EXIST|account.none|계정정보 없음.|
|ACCOUNT_SESSION_DUPLICATED||EG 계정이 이미 생성되어 있음. 세션이 이미 생성된 상황에서 게스트 계정을 생성하는 경우 발생합니다.|
|ACCOUNT_ALREADY_EXIST|account.duplicate|이미 등록된 계정임. SNS 계정 연계시 연동하려는 SNS 계정이 이미 연동되어 있는 경우 발생합니다.|
|ACCOUNT_INVALID_PROPERTY|account.value|유효하지 않은 계정 속성을 조회함.|
|ACCOUNT_SYNC_FAIL|account.sync|계정연동 실패함.|

## 플랫폼 결제

EG 플랫폼의 결제와 관련된 예외코드를 정의합니다. 이 유형의 예외 코드들은 ***BILL_*** 로 시작합니다.

|예외코드| API Code | 설명 |
|-|-|-|
|BILL_FORBIDDEN_USER|user.forbidden|결제 금지된 사용자.|
|BILL_INVALID_PRODUCT|product.forbidden|판매가 허가 되지 않거나 등록되지 않은 상품.|
|BILL_PAYLOAD_MISMATCH|payload.mismatch|결제 서버에서 발급한 페이로드가 일치하지 않음.|
|BILL_SIGNATURE_MISMATCH||결제 API 인증키가 일치하지 않음.|
|BILL_ERROR||기타 이유로 결제가 실패함.|

## 기타

기타 예외코드를 정의합니다.

|예외코드|설명 |
|-|-|
|PROCESS_CONTRACT_DENIED|약관 동의 거부.|