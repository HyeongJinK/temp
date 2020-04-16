# 결제 컨트롤

`PaymentControl` 은 아이템 구매 및 결제 서비스를 담당합니다. EG 플랫폼의 안드로이드 SDK는 구글 플레이의 인앱 서비스를 지원하고 있습니다.

## 객체 생성

`PaymentControl` 클래스는 옵션을 입력받는 factory 메소드를 가지고 있습니다. 이 factory 메소드를 이용해 객체를 생성합니다.

```java
    // 구글 플레이 인앱 결제를 위한 Payment Control 객체를 생성합니다.
    // 객체를 생성하기 위해서는 옵션을 설정해야 합니다.
    PaymentControl.Option option = new PaymentControl.Option()
            .implicitRestore(true)
            .platformApiKey(context.getString(R.string.google_payment_public_key))
            .restoreListener(new ProcessListener<String[]>() {
                @Override public void onComplete(String[] restores) {
                    // restore 목록 조회 완료 핸들러 작성
                    // 미지급된 아이템(상품)의 order id 를 Array 로 받습니다.
                }

                @Override public void onError(@NotNull Throwable t) {
                    // restore 목록 조회 실패 핸들러 작성
                }
            })
            .purchaseListener(new ProcessListener<String>() {
                @Override
                public void onComplete(String orderId) {
                    // 구매 완료 핸들러 작성
                }

                @Override public void onError(@NotNull Throwable t) {
                    // 구매 실패 핸들러 작성
                }
            });

    PaymentControl payControl = PaymentControl.createControl(context, option);
```

### PaymentControl.Option

구매 Control 객체를 생성하기 위한 옵션은 다음과 같습니다.

#### implicitRestore

* implicitRestore 옵션은 Control 객체 생성시 자동으로 구매 복구 프로세스 실행 여부를 결정합니다.
* 이 옵션의 기본값은 `true` 입니다. 이 옵션이 활성화 되어 있으면 `PaymentControl` 객체가 생성되고 난 후 자동으로 미지급 아이템(상품) 목록을 조회하여 클라이언트에 전달합니다.

#### platformApiKey

* 결제 플랫폼의 API 인앱 결제 공개키 값입니다.
* Google Play Console 의 경우 API 인앱 결제 공개키를 생성 및 발급해 줍니다. 클라이언트는 이 공개키를 이용해 사용자를 인증하게 됩니다. 따라서 이 값은 반드시 설정해야 합니다.
* 인앱 결제 공개키는 앱 내에서 안전하게 관리되어야 합니다.

#### restoreListener

* Control 객체에서 조회한 restore 아이템(상품) 목록에 대한 처리를 위한 핸들러를 등록합니다.
* 콜백으로 넘어오는 인자는 미지급된 아이템(상품)의 `orderId` 를 Array 로 받습니다.
* 이 핸들러에서 미지급된 아이템에 대한 지급 처리를 합니다.

#### purchaseListener

* Control 객체로 구매한 아이템(상품)에 대한 처리를 위한 핸들러를 등록합니다.
* 콜백으로 넘어오는 인자는 구매한 아이템(상품)에 대한 `orderId` 입니다.
* 이 핸들러에서 아이템에 대한 지급 처리를 합니다.

## Product Restore

미지급된 구매 아이템(상품) 복구

앱에서 결제한 아이템은 게임 서버를 통해 지급 처리를 요청하게 됩니다. 이때 불안정한 네트워크등 여러 상황에 따라 구매한 아이템이 미지급 될 수도 있습니다. 어떠한 상황이든 사용자가 구매한 아이템에 대해 확실한 지급 처리를 보장해야 합니다.

EG 플랫폼 SDK의 구매 모듈은 Control 객체가 생성되고 로드될때 암묵적으로 미지급 아이템들을 처리하는 기능을 제공하고 있습니다.

암묵적 Restore 기능은 `PaymentControl` 객체를 생성할때 `implicitRestore`옵션으로 설정 할 수 있으며 기본값은 `true` 입니다. 이 옵션값을 `false` 로 지정할 경우 `restore()` 메소드를 호출 함으로써 미지급 아이템에 대한 지급 처리를 진행 할 수 있습니다.

```java
pymentControl.restore();        // 미지급된 아이템 목록을 처리합니다.
```

## Purchase

아이템(상품) 구매

아이템의 구매는 `PaymentControl` 객체의 `purchase()` 메소드를 통해 진행 할 수 있습니다.

#### purchase

* 입력 파라미터 : productId - 구글 플레이 인앱에 등록된 상품 코드입니다.

```java
paymentControl.purchase(activity, "product.id");
```

#### onActivityResult

아이템을 구매하기 위해서는 결제 정보 입력, 구매 동의등의 사용자와 상호작용이 필요합니다. 따라서 구매 완료를 처리하기 위해 result callback 을 등록해야 합니다. Control 객체의 콜백은 `onActivityResult` 메소드에 등록해 주면 됩니다.

```java
public void onActivityResult(int requestCode, int responseCode, Intent data) {
    ...
    paymentControl.onActivityResult(requestCode, responseCode, data);
}
```

## Product 조회

아이템(상품) 조회

앱 클라이언트는 `PaymentControl` 객체의 `product()` 메소드를 통해 인앱에 등록된 상품 정보를 조회 할 수 있습니다.

#### product

* 입력 파라미터 : productId - 구글 플레이 인앱에 등록된 상품 코드입니다.
* Return : TaskData - 상품 조회는 기본적으로 비동기적으로 작동합니다.

```java
TaskData<Product> product = paymentControl.product("product.id")
product.getAsync(new AsyncReceiver<Product> {
    @Override public void receive(Product product) {
        // ... 상품정보를 처리하는 코드
    }
});
```

> 상품 정보 조회를 동기적으로 처리하고 싶은 경우 `TaskData` 의 `get()` 메소드를 사용하세요. `Future` 와 동일하게 동작합니다.

```java
Product product = paymentControl.product("product.id").get();
```