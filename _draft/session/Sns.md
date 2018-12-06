# SNS 계정연동

플랫폼 SDK는 SNS 계정에 로그인 하고 플랫폼 계정과 연동하는 역할을 하는 `SignInControl` 클래스를 제공합니다.

현재 플랫폼이 제공하는 SNS 계정연동은 Facebook 과 Google 입니다. SNS 계정연동은 Android Framework 에서 제공하는 순수 컴포넌트만을 이용할 수도 있고, EG 플랫폼에서 제공하는 로그인 버튼 컴포넌트나 로그인 대화창 (Activity 기반)을 이용할 수도 있습니다.

계정연동은 다음과 같은 순서로 할 수 있습니다.

## 기본 버튼으로 로그인

#### 1. 레이아웃에 버튼 배치

```xml
<Button 
    android:id="@+id/btn_facebook_login" 
    android:layout_width="match_parent"
    android:layout_height="wrap_content" 
    android:layout_margin="5dp" 
    android:text="Facebook Login"/>
```

#### 2. SignInControl 설정 (in Activity)

`SignInControl` 객체는 `onActivityResult` 콜백에 등록해야 합니다. 따라서 인스턴스 변수로 생성해야합니다.

```java
// Sign in option 설정
SignInControl.Option option = new SignInControl.Option()
        .setSignInResultHandler(new SignInResultHandler() {
            @Override
            public void onComplete(Result.Login result) {
                // 로그인 성공 핸들러 작성
            }

            @Override
            public void onError(Throwable t) {
                // 로그인 실패 핸들러 작성
            }

            @Override
            public void onCancel() {
                // 로그인 취소 핸들러 작성 
            }
        });

// SignInControl 객체생성
SignInControl signInControl = SignInControl.createControl(activity, option);
```

#### 3. Button 핸들러에 연결
로그인 버튼을 눌렀을때 로그인을 시도하도록 핸들러에 등록합니다.

```java
Button facebookLogin = findViewById(R.id.btn_facebook_login);
facebookLogin.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        signInControl.signIn(Provider.FACEBOOK, activity);
    }
});
```

#### 4. ActivityResult 핸들러 작성

로그인 결과를 핸들러에 전달 할 수 있도록 Activity.onActivityResult 메소드를 작성합니다.

```java
@Override
public void onActivityResult(int requestCode, int resultCode, Intent data) {
    signInControl.onActivityResult(requestCode, resultCode, data);
}
```

## EG SDK 제공 버튼으로 로그인

#### 1. 레이아웃에 버튼 배치

```xml
<com.estgames.framework.ui.buttons.FacebookSignButton 
        android:id="+@id/btn_facebook_login" 
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

<com.estgames.framework.ui.buttons.GooogleSignButton 
        android:id="+@id/btn_google_login" 
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>
```

#### 2. SignInControl 설정 (in Activity)

`SignInControl` 객체는 `onActivityResult` 콜백에 등록해야 합니다. 따라서 인스턴스 변수로 생성해야합니다.

레이아웃 xml 파일에 명시한 `SignButton`을 Control 객체와 연결합니다.

```java
// Sign in option 설정
SignInControl.Option option = new SignInControl.Option() 
        .addSignButton((SignButton) findViewById(R.layout.btn_facebook_login))
        .addSignButton((SignButton) findViewById(R.layout.btn_google_login))
        .setSignInResultHandler(new SignInResultHandler() {
            @Override
            public void onComplete(Result.Login result) {
                // 로그인 성공 핸들러 작성
            }

            @Override
            public void onError(Throwable t) {
                // 로그인 실패 핸들러 작성
            }

            @Override
            public void onCancel() {
                // 로그인 취소 핸들러 작성 
            }
        });

// SignInControl 객체생성
SignInControl signInControl = SignInControl.createControl(activity, option);
```

#### 3. ActivityResult 핸들러 작성

로그인 결과를 핸들러에 전달 할 수 있도록 Activity.onActivityResult 메소드를 작성합니다.

```java
@Override
public void onActivityResult(int requestCode, int resultCode, Intent data) {
    signInControl.onActivityResult(requestCode, resultCode, data);
}
```

## EG SDK 제공 대화창(SignInActivity)으로 로그인

#### 1. SignInControl 설정 (in Activity)

`SignInControl` 객체는 `onActivityResult` 콜백에 등록해야 합니다. 따라서 인스턴스 변수로 생성해야합니다.

레이아웃 xml 파일에 명시한 `SignButton`을 Control 객체와 연결합니다.

```java
// Sign in option 설정
SignInControl.Option option = new SignInControl.Option()
        .setSignInResultHandler(new SignInResultHandler() {
            @Override
            public void onComplete(Result.Login result) {
                // 로그인 성공 핸들러 작성
            }

            @Override
            public void onError(Throwable t) {
                // 로그인 실패 핸들러 작성
            }

            @Override
            public void onCancel() {
                // 로그인 취소 핸들러 작성 
            }
        });

// SignInControl 객체생성
SignInControl signInControl = SignInControl.createControl(activity, option);
```

#### 2. ActivityResult 핸들러 작성

로그인 결과를 핸들러에 전달 할 수 있도록 Activity.onActivityResult 메소드를 작성합니다.

```java
@Override
public void onActivityResult(int requestCode, int resultCode, Intent data) {
    signInControl.onActivityResult(requestCode, resultCode, data);
}
```

#### 3. 로그인 대화창 호출

```java
signInControl.signIn(activity);
```