# ActionListener 구현 및 등록

`ActionListener`에서는 팝업창에서 정상종료, 취소, 에러시 일어나야할 작업을 구현한다.


|이름|설명|매개변수|
|-|-|-|
|onDone|정상종료|성공 결과값(타입은 제너릭), 팝업마다 결과타입이 다르다.|
|onCancel|X버튼 혹은 취소||
|onError|에러|에러핸들러로 에러종류를 구분합니다.|


### 예)

```java
Action<String> starting = client.starting(this);

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
    }
});

starting.go();
```