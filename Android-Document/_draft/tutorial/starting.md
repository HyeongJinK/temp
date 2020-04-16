# 플랫폼 기본 스타트 액션 호출하기

이 튜토리얼 문서는 EG 플랫폼을 연동하고 간단하게 플랫폼 시작 액션을 호출 하는 방법을 설명하고 있습니다. 좀 더 자세한 내용은 [EgClient 메뉴얼](/_draft/egclient/init.md)를 참조하기 바랍니다.
이 튜토리얼 문서는 사용자의 명시적인 로그인을 통해 세션을 생성한다고 가정하고 진행합니다.

## `EgClient` 생성

`EgClient` 객체는 EG 플랫폼의 Context 정보 및 기본 액션들을 포함 하고 있는 객체입니다.
`EgClient` 객체는 App 내에서 전역적으로 한개의 객체만 생성되고 유지됩니다.

```java
EgClient client = EgClient.from(getApplication());
//or
EgClient client = EgClient.from(getApplicationContext();
```

## Starting Action

EG 플랫폼을 연동하는 경우 플랫폼에서 제공하는 [액션](/_draft/egclient/Action.md)들을(약관, 배너, 공지사항 등) 사용할 수 있습니다. 시작 액션은 앱이 시작할때 동작해야 하는 액션 프로세스를 정의한 액션입니다. Starting Action을 호출하는 것으로 앱 시작과 동시에 진행 되어야 할 액션 프로세스를 진행 할 수 있습니다.

```java
    // Starting Action 객체 생성
    Action starting = client.starging();

    // Starting Action Listener 적용
    starting.setListener(new ActionListener<String>() {
         @Override
        public void onDone(String response) {
            // 프로세스 완료 핸들러 작성
        }

        /** 생략가능 **/
        @Override
        public void onCancel() {
            // 프로세스 취소 핸들러 작성
        }

        /** 생략가능 **/
        @Override
        public void onError(Throwable t) {
            // 프로세스 에러 핸들러 작성
        });

    // Action 실행
    starting.go();
```