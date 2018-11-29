# 게스트 계정의 식별자 생성

EG 플랫폼 SDK 에서는 3가지 유형으로 게스트 계정의 식별자를 생성 할 수 있습니다. 각 유형에 따라 기기에서 게스트 계정을 지속 가능한 또는 휘발성 계정으로 생성 할 수 있습니다.

게스트 계정의 생성 유형은 `confgiruation` 또는 ***egconfiguration.json*** 파일에서 설정 할 수 있습니다.

## Device 기반 식별자 생성

디바이스 기반으로 게스트 계정 식별자를 생성하게 되면 한 디바이스당 하나의 게스트 계정만 생성합니다. 앱을 삭제한 후 재설치를 하는 경우에도 같은 게스트 계정의 유지를 보장합니다.

> 기기에 따라서 앱 삭제 후 재설치시 같은 게스트 계정을 보장하지 못 할 수도 있습니다.

EG 플랫폼에서는 이 모드를 기본값으로 설정합니다.

* 설정 옵션
  * `configuration` : DeviceUserIdentityGenerator.class
  * json 설정 파일 : device

## App 기반 식별자 생성

앱 기반으로 게스트 계정 식별자를 생성하게 되면 같은 디바이스에서 앱 별로 게스트 계정 유지를 보장합니다. 앱을 삭제한 후 재설치를 하는 경우에는 게스트 계정을 유지하지 않습니다. 즉 앱을 재설치하는 경우 게스트 계정으로 로그인 하는경우 다른 게스트 계정을 생성합니다.

* 설정 옵션
  * `configuration` : AppUserIdentityGenerator.class
  * json 설정 파일 : app

## Instant 식별자 생성

휘발성 게스트 계정을 생성합니다. 이 모드로 앱을 설정하면 게스트를 로그아웃 할떄 게스트 계정을 잃어버리게 됩니다.

* 설정 옵션
  * `configuration` : InstantUserIdentityGenerator.class
  * json 설정 파일 : instant