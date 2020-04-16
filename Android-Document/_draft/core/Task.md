# Task API

`Task` 클래스는 ***Promise*** 패턴을 구현한 비동기 코드 호출 API 입니다. `Task` API로 호출한 결과로 콜백을 호출 하도록 등록 할 수 있습니다. 콜백은 안드로이드의 UI 화면에 결과를 표현해야 하는 경우도 있습니다. 따라서 콜백 메소드는 안드로이드의 UI 스레드에서 실행이 됩니다. `Task` API 내부적으로는 콜백을 UI 스레드에서 실행하기 위해 Android의 Handler API를 구현합니다.

`Task` 클래스는 메소드 체인을 이용한 플루언트 인터페이스를 지원합니다.

## 비동기 코드 호출과 결과 처리

EG 플랫폼 SDK 에서 Task API 를 사용하는 대표적인 예제는 `SessionManager` 입니다. 다음 예제는 이미 생성된 세션을 재시작 하는 예제입니다. resume() 메소드는 `Task` 객체를 반환합니다.

```java
    Task<String> resumeTask = EgClient.getSessionManager().resume();
```

`Task` API를 사용하기 위해서는 비동기 코드 호출 후의 콜백 코드를 등록해야 합니다. 다음은 새션 재시작이 성공된 후 콜백 처리에 대한 예제 입니다.

```java
    resumeTask.asyncAccept(new Task.Acceptor<String>() {
        @Override
        public void accept(String result) {
            // 결과로 넘어온 값을 처리하는 핸들러를 작성
            // resume 메소드의 결과값은 eg_token 이다.
        }
    });
```

`Task` 객체에 `asyncAccept` 메서드로 `Acceptor` 인터페이스를 등록하므로써 비동기 처리 결과값을 받아와 처리 합니다.

> `asyncAccept` 메소드를 호출하면 `Task`에 등록된 코드를 호출하고 결과를 받아 `Acceptor`에 넘겨줍니다.

비동기 호출에 대한 예외 처리 역시 예외처리 콜백을 등록해 처리가 가능합니다. 다음은 예외 처리에 대한 예제입니다.

```java
    resumeTask.onError(new Task.Acceptor<EGException>() {
        @Override
        public void accept(EGException e) {
            // 비동기 호출시 발생한 예외처리 핸들러 작성.
            // 지정한 예외만 선택해서 catch 할 수 있음.
            if (Fail.TOKNE_INVALIDE == e.getCode()) {
                ...
            }
        }
    });
```

`onError` 메서드를 이용해 예외 핸들러를 등록 할 수 있습니다. 예외 핸들러 역시 `Acceptor` 인터페이스를 구현하면 됩니다.

## 비동기 Task 연결

`Task` API 는 비동기 호출 코드를 `Task` 체인으로 연결할 수 있습니다. `thenApply` 메소드를 이용해 호출 코드를 다음과 같이 등록 합니다.

```java
    Task<Integer> countTask = resumeTask.thenApply(new Task.Applier<String, Integer>() {
        @Override
        public Integer apply(String token) {
            // 결과로 넘어온 eg token 문자열을 토큰 길이로 변환하는 예제.
            // eg token의 길이를 반환한다.
            return token.length();
        }
    });
```

`Task` 객체의 `thenApply` 메소드는 비동기 호출 코드를 포함한 `Task` 객체를 반환합니다. 이 작업들은 메소드 체인으로 연결할 수 있습니다.

```java
    Task<String> resumeTask = EgClient.getSessionManager()
            .resume()
            .thenApply(new Task.Applier<String, Integer>() {
                @Override
                public Integer apply(String token) {
                    // 결과로 넘어온 eg token 문자열을 토큰 길이로 변환.
                    return token.length();
                }
            })
            .onError(new Task.Acceptor<EGException>() {
                @Override
                public void accept(EGException e) {
                    // 비동기 호출시 발생한 예외처리 핸들러 작성.
                    // 지정한 예외만 선택해서 catch 할 수 있음.
                    if (Fail.TOKNE_INVALIDE == e.getCode()) {
                        ...
                    }
                }
            })
            .asyncAccept(new Task.Accept() {
                @Override
                public void accept(Integer result) {
                    // 결과를 화면에 보여줌.
                    Toast.makeText(context, "Token length is " + result, Toast.LENGTH_SHORT).show();
                }
            });

```

## Thread Executor

`Task` API 는 비동기 코드를 호출하기 위해 스레드를 생성해 사용합니다. 만약 스레드를 관리하기 위해 Task 객체에 `Executor` 를 지정할 수 있습니다.

Thread Pool 을 생성하고 `Executor` 얻어옵니다.

```java
    ThreadPoolExecutor executor = new ThreadPoolExecutor(
        numCores * 2, numCores *2, 60L, TimeUnit.SECONDS, new LinkedBlockingQueue<Runnable>());

    // or

    Executor executor = Executors.newScheduledThreadPool(10);
```

`Executor`를 Task 객체에 등록합니다.

```java
    Task<Object> task = new Task(executor, new Callable());
```

## 동기적 처리

`Task` API 의 동작은 기본적으로 비동기적으로 처리가 됩니다. 그러나 경우에 따라 비동기 코드를 동기적으로 처리해야 하는 경우도 있습니다.
이런 경우 `get()` 메소드를 호출 하므로써 블로킹을 걸어 동기적으로 처리 할 수 있습니다.

```java
    Task<String> resumeTask = EgClient.getSessionManager().resume();
    // 블록킹을 걸어 동기적으로 결과를 얻습니다.
    String token = resumeTask.get();
```

> Java Concurrency API 의 `Future` API와 동일하게 동작합니다.

## TaskData

안드로이드에서 네트워크를 통한 데이터를 받기 위해서는 반드시 서브 스레드에서 네트워크 호출 코드를 작성해야 합니다. `TaskData`는 비동기 호출시 예외처리 및 다음 비동기 호출을 연계할 필요없이 단일 코드만 호출 할 경우 `Task` 객체 대신 간단하게 사용 할 수 있습니다.

> `TaskData` 대신 Java Concurrency API `Future` 를 사용해도 무방합니다. `TaskData` 는 내부적으로 `Future` API 를 사용합니다.

```java
    TaskData<String> data = new TaskData(new Callable<String> {
        // 비동기 호출 코드
        return "text value"
    })
```

### 비동기 결과 처리

```java
    data.getSync(new AsyncReceiver<String>() {
        @Override
        public void receive(String data) {
            // 데이터 Revceived 처리
        }
    });
```

### 동기적 결과 처리

```java
    // 데이터를 받아올때 까지 Blocking
    String result = data.get();
```