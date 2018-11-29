# Client 설정정보 import

EGMP SDK 는 res/raw 디렉토리에 위치한 설정 파일을 읽어 framework 초기화를 실행합니다.
따라서 SDK에서 필요한 설정 파일을 해당 디렉토리(res/raw) 아래에 위치시켜야 합니다.
필요한 파일은 다음과 같습니다.

* egconfiguration.json

설정 파일은 MP Console 에서 다운로드를 제공할 예정입니다.

```json
{
  "Client" : {
    "ClientId": "sample-client-id.sample.estgames.com",
    "Secret": "sample-app-secret-code",
    "Region": "sample.global.stage"
  },

  "Account": {
    "Guest": {
      "Identity": "Device"
    },
    "Google": {
      "Permissions": "email, profile, openid"
    },
    "Facebook": {
      "Permissions": "public_profile, email"
    }
  }
}
```

## Client

앱의 인증 및 기본 설정 정보를 지정합니다. 클라이언트 아이디, 앱 시크릿, Region 정보를 설정합니다.

* ClientId : 클라이언트 아이디
* Secret : 앱 시크릿
* Region : 서비스 Region 코드

## Account

앱의 사용자 계정에 대한 설정 정보를 지정합니다. 게스트의 식별자 생성방법, SNS 프로바이더등을 설정합니다.

* Guest : 게스트 계정에 대한 설정을 합니다.
  * Identity - 게스트 계정 식별자 생성 방법을 설정합니다. 설정값은 device, app, instant 중 하나를 설정하면 됩니다.

* Google, Facebook : 구글, 페이스북 연동 설정을 합니다.
  * permissions - SNS 계정 연동시 요청할 퍼미션 정보를 설정합니다.