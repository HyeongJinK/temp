package com.estgames.estgames_framework.common

import android.app.Activity
import android.content.Context
import com.amazonaws.mobile.auth.core.*
import com.amazonaws.mobile.auth.facebook.FacebookButton
import com.amazonaws.mobile.auth.google.GoogleButton
import com.amazonaws.mobile.auth.ui.AuthUIConfiguration
import com.amazonaws.mobile.auth.ui.SignInActivity
import com.estgames.estgames_framework.core.Result
import com.estgames.estgames_framework.core.session.SessionManager
import com.estgames.estgames_framework.user.*
import java.lang.Exception
import java.util.function.Consumer

/**
 * Created by mp on 2018. 5. 2..
 */
public class UserService constructor(callingActivity: Activity, applicationContext: Context) {
    var callingActivity = callingActivity
    var app = applicationContext

    var userLinkDialog : UserLinkDialog = UserLinkDialog(callingActivity, Runnable { userLoadDialog.show() }, Runnable { userGuestLinkDialog.show() }, Runnable { signout() })
    var userLoadDialog : UserLoadDialog = UserLoadDialog(callingActivity, Runnable { onSwitch() }, Runnable { signout() })
    var userGuestLinkDialog : UserGuestLinkDialog = UserGuestLinkDialog(callingActivity, Runnable { signout() }, Runnable { onSync() }, Runnable { userLinkDialog.show() })
    var userResultDialog : UserResultDialog = UserResultDialog(callingActivity, Runnable { goToLoginSuccessCallBack.run() }, Runnable { goToLoginSuccessCallBack.run() })

    /**
     * 콜백함수
     * */
    public var startSuccessCallBack: Runnable = Runnable {  }
    public var startFailCallBack: CustomConsumer<String> = CustomConsumer {  }
    public var goToLoginSuccessCallBack: Runnable = Runnable {  }
    public var goToLoginFailCallBack: CustomConsumer<String> = CustomConsumer {  }
    public var goToLoginConfirmCallBack: Runnable = Runnable {  }
    public var clearSuccessCallBack: Runnable = Runnable {  }

    val sessionManager: SessionManager by lazy {
        SessionManager(callingActivity)
    }

    val identityManager: IdentityManager by lazy {
        IdentityManager.getDefaultIdentityManager()
    }

    val complete: (String) -> Unit = {t ->
        identityManager.login(callingActivity, object: DefaultSignInResultHandler() {
            override fun onSuccess(activity: Activity?, provider: IdentityProvider?) {
                /**
                 * identityManager 콜백에서(Child 스레드를 통해 cognito identity ID 를 가져옴.)
                 * 메인 스레드 UI 접근 불가로 MainActivity 를 다시 실행 시킴.
                 * sync 에러가 발생한 경우 MainActivity 실행시 충동 이벤트 객체를 같이 넘겨줌.
                 */
                identityManager.getUserID(object: IdentityHandler{
                    override fun onIdentityId(identityId: String?) {
                        sessionManager
                                .sync(hashMapOf("provider" to provider!!.displayName, "email" to "test@facebook.com"), identityId)
                                .right {
                                    //성공했을 경우
                                    goToLoginSuccessCallBack.run()
                                }
                                .left {
                                    //충돌이 발생했을 경우
                                    err ->
                                    //var event: Result = err

                                    userLinkDialog.show()

                                }
                    }
                    override fun handleError(exception: Exception?) {
                        goToLoginFailCallBack.accept(exception.toString())
                    }
                })
            }

            override fun onCancel(activity: Activity?): Boolean {
                return false
            }
        })
        startSuccessCallBack.run()
    }

    val fail: (Throwable) -> Unit = {t ->
        startFailCallBack.accept(t.toString())
        //Toast.makeText(callingActivity, "Error !! $t", Toast.LENGTH_SHORT)
    }

    public fun createUser() {
        identityManager.resumeSession(
                callingActivity,
                { result ->
                    if (sessionManager.hasSession) {
                        sessionManager.open().right(complete).left(fail)
                    } else {
                        result.identityManager.getUserID(object : IdentityHandler {
                            override fun handleError(e: Exception?) {
                                startFailCallBack.accept(e.toString())
                                //Toast.makeText(callingActivity, "Error !! $e", Toast.LENGTH_SHORT)
                            }

                            override fun onIdentityId(identityId: String?) {
                                sessionManager.create(principal=identityId!!).right(complete).left(fail)
                            }
                        })
                    }
                },
                200
        )
    }

    public fun goToLogin() {
        val config = AuthUIConfiguration.Builder()
                .signInButton(FacebookButton::class.java)
                .signInButton(GoogleButton::class.java)
                .userPools(false)
                .build()
        SignInActivity.startSignInActivity(callingActivity, config)
    }

    public fun signout() {
        if (identityManager.isUserSignedIn) {
            identityManager.signOut()
        }
    }

    public fun logout() {
        if (identityManager.isUserSignedIn) {
            identityManager.signOut()
        }
        sessionManager.signOut()
        clearSuccessCallBack.run()
    }

    /**
     * Sync Dialog 핸들러 메서드.
     * 계정전환 버튼을 눌렀을 경우.
     */
    fun onSwitch() {
        sessionManager.create(identityManager.cachedUserID).right {
            userResultDialog.show()
        }.left {
            goToLoginFailCallBack.accept("sign in fail : $it")
            identityManager.signOut()
        }
    }

    /**
     * Sync Dialog 핸들러 메서드.
     * 계정연동 버튼을 눌렀을 경우.
     */
    fun onSync() {
        val provider = identityManager.currentIdentityProvider.displayName
        sessionManager.sync(
                mapOf("provider" to provider), identityManager.cachedUserID, true
        ).right {
            userResultDialog.show()
        }.left {
            goToLoginFailCallBack.accept("sync fail : $it")
            identityManager.signOut()
        }
    }
}