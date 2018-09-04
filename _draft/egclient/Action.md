# Action

`Action`은 해당 라이브러리에서 제공하는 팝업창 동작에 대한 클래스입니다.
앞에서 생성한 `EgClient`에서 원하는 팝업창에 대한 `Action`을 생성합니다.

## EgClient에서 Action 클래스를 만드는 함수

* 해당 함수들은 공통적으로 `com.estgames.framework.Action` 클래스를 리턴한다.
* `android.app.Activity`을 매개변수로 받는 다. 해당 팝업을 띄울 액티비티를 매개변수로 받는 다.
* `Action` 클래스에 `go` 함수로 팝업창을 띄울 수 있다.

| 메소드 이름 | 설명 |
|-|-|-|-|
|starting|API에서 지정된 순서대로 팝업창을 띄우는 액션|
|authority|권한|
|banner|배너|
|policy|이용약관|
|notice|공지사항|
|cs|고객센터|
|event|이벤트|


 ### 예)

 ```java
Action<String> starting = client.starting(this);
starting.go();
 ```