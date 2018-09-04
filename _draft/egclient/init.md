# EgClient 메뉴얼

이용약관, 배너, 공지... 등 게임에서 사용되는 공통 모듈은 `EgClient` 클래스에 정의되어있습니다.

`EgClient` 객체에서 각각의 팝업창으로 나오는 기능에 대해서는 `Action` 객체를 생성처리하며 나라, 국가관련 정보는 문자열로 리턴합니다.
 
`Action` 객체에서는 팝업창 관련 클래스입니다. 해당 객체에서는 일어나야할 동작을 등록하고 기능을 실행합니다.
  
`ActionListener` 인터페이스에서는 팝업창에서 성공, 취소, 에러시 일어나야 할 동작을 구현합니다.

이 장은 아래와 같은 내용으로 구성됩니다.

* [EgClient 생성합니다.](/_draft/egclient/Create.md)
* [각각의 팝업에 대한 Action을 생성하고 실행합니다.](/_draft/egclient/Action.md)
* [ActionListener 구현 하고 Action에 등록합니다.](/_draft/egclient/ActionListener.md)
* [EgClient 그외 함수들의 대해 알아봅니다.](/_draft/egclient/Etc.md)