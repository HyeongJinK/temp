# Client 설정정보 import

EGMP SDK 는 res/raw 디렉토리에 위치한 설정 파일을 읽어 framework 초기화를 실행합니다.
따라서 SDK에서 필요한 설정 파일을 해당 디렉토리(res/raw) 아래에 위치시켜야 합니다.
필요한 파일은 다음과 같습니다.

* egconfiguration.json

설정 파일은 MP Console 에서 다운로드를 제공할 예정입니다.

```json
{
  "Client" : {
    "ClientId": "0eae170b-ec59-3f85-bfda-a8c80fc1a3fe.mp.estgames.com",
    "Secret": "13949b24f1fd9d3c81aabd11295c28507ee0a977e9dc5dc93a3bea86f8243b46",
    "Region": "cm.global.stage"
  },

  "AccountProviders": {
    "Google": {
      "Permissions": "email, profile, openid"
    },
    "Facebook": {
      "Permissions": "public_profile, email"
    }
  }
}
```