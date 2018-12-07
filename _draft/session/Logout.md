# 로그아웃하기

## _SessionManager.signOut()_

* Parameter : 없음
* Return _`Task<Unit>`_

EG 플랫폼 세션을 종료하기 위해서 사용합니다. 현재 사용중인 세션만 종료하며 계정은 삭제 되지 않습니다.
`signOut()`을 호출하게 되면 시스템적으로 사용자 세션을 만료(Expire)시킵니다.

> 휘발성 게스트 계정의 경우 `sign out`을 하면 계정을 잃어버릴 수 있습니다.

```java
    sessionManager.signOut()
        .asyncAccept(new Task.Acceptor() {
            @Override public void accept(Object o) {
                // 세션 종료 핸들러 작성
                System.out.println("로그아웃");
            }
        });
```