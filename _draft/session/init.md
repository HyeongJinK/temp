# 플랫폼 계정 연동

플랫폼 계정 연동에 가장 먼저할 작업은 `SessionManager`를 생성하는 일입니다. 매니져에서는 게스트 유저로의 로그인, 유저정보(세션) 조회, 로그아웃(세션종료)을 처리합니다.

`SessionManager`는 토큰 생성, 갱신, 만료, 세션 종료등 EG 모바일 플랫폼의 세션 및 토큰 관리를 담당하는 객체입니다.

Sns 연동은 `SignInControl`에서 처리하며 라이브러리에서 제공하는 버튼을 사용하여 화면을 만들거나 기본으로 제공하는 로그인 팝업창을 사용하여 로그인을 처리합니다.

이 장은 아래내용으로 구성됩니다.

* [세션 매니저 생성합니다.](/_draft/session/Create.md)
* [세션 생성(게스트 로그인) 및 세션 갱신](/_draft/session/Open.md)
* [세션, 유저 정보 조회하기](/_draft/session/Select.md)
* [로그아웃 하기](/_draft/session/Logout.md)
* [SNS 계정연동 하기](/_draft/session/Sns.md)