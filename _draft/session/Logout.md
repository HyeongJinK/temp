# 로그아웃하기

`SessionManager`에 있는 <span style="color:red">signOut</span> 메소드로 로그아웃을 진행합니다. 

```java
sessionManager.signOut().asyncAccept(new Task.Acceptor() {
    @Override public void accept(Object o) {
        // 세션 종료 핸들러 작성
        System.out.println("로그아웃");
    }
});
```