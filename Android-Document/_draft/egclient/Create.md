# 객체 생성

`EgClient`에서는 원하는 기능들에 대한 `Action`들을 생성합니다. 여기서는 `EgClient`를 초기화하는 함수를 알아봅니다.

## 객체 생성 함수

| 메소드 이름 | 리턴 값 | 매개변수 |
|-|-|-|
|from|com.estgames.framework.EgClient|android.content.Context|

### 예)

```java
EgClient client = EgClient.from(getApplication());
//or 
EgClient client = EgClient.from(getApplicationContext();
```