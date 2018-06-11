package com.estgames.estgames_framework.common

import android.app.Activity
import com.amazonaws.mobile.auth.core.*
import com.amazonaws.mobile.auth.facebook.FacebookButton
import com.amazonaws.mobile.auth.google.GoogleButton
import com.amazonaws.mobile.auth.ui.AuthUIConfiguration
import com.amazonaws.mobile.auth.ui.SignInActivity
import com.estgames.estgames_framework.core.EGException
import com.estgames.estgames_framework.core.Fail
import com.estgames.estgames_framework.core.Result
import com.estgames.estgames_framework.core.session.SessionManager
import com.estgames.estgames_framework.user.*
import java.lang.Exception

/**
 * Created by mp on 2018. 5. 2..
 */
public class UserService constructor(callingActivity: Activity) {
    var callingActivity = callingActivity

    /**
     *  팝업에 텍스트 설정하기
     * */
    var userLinkMiddleText: CustormSupplier<String>? = null
    var userLinkBottomText: CustormSupplier<String>? = null
    var userLoadText: CustormSupplier<String>? = null
    var userGuestText: CustormSupplier<String>? = null

    var userAllDialog: UserAllDialog? = null

    /**
     * 콜백함수
     * */
    var failCallBack: CustomConsumer<Fail> = CustomConsumer {  }
    var startSuccessCallBack: Runnable = Runnable {  }
    var clearSuccessCallBack: Runnable = Runnable {  }
    var back:CustomConsumer<Activity> = CustomConsumer {  }

    var loginResultHandler: LoginResultHandler = object: LoginResultHandler {
            override fun onComplete(result: Result.Login) { }
            override fun onFail(code: Fail) { }
            override fun onCancel() { }
        }

    val sessionManager: SessionManager by lazy {
        SessionManager(callingActivity)
    }

    val identityManager: IdentityManager by lazy {
        IdentityManager.getDefaultIdentityManager()
    }

    fun createUser() {
        identityManager.resumeSession(
                callingActivity,
                { result ->
                    if (sessionManager.hasSession) {
                        sessionManager.open()
                                .right { startSuccessCallBack.run() }
                                .left { failCallBack.accept(it.code) }
                    } else {
                        result.identityManager.getUserID(object : IdentityHandler {
                            override fun handleError(e: Exception?) {
                                failCallBack.accept(Fail.TOKEN_CREATION)
                            }

                            override fun onIdentityId(identityId: String?) {
                                sessionManager.create(principal=identityId!!)
                                        .right { startSuccessCallBack.run() }
                                        .left { failCallBack.accept(it.code)}
                            }
                        })
                    }
                },
                200
        )
    }

    fun goToLogin() {
        initLoginHandler()
        callingActivity.runOnUiThread(Runnable {
            val config = AuthUIConfiguration.Builder()
                    .signInButton(FacebookButton::class.java)
                    .signInButton(GoogleButton::class.java)
                    .userPools(false)
                    .build()
            SignInActivity.startSignInActivity(callingActivity, config)
        })
    }

    fun goToLogin(config: AuthUIConfiguration) {
        initLoginHandler()
        SignInActivity.startSignInActivity(callingActivity, config)
    }

    private fun initLoginHandler() {
        // Cognito 의 SNS 로그인 결과 Handler 등록.
        identityManager.login(callingActivity, object: DefaultSignInResultHandler() {
            override fun onSuccess(activity: Activity?, provider: IdentityProvider?) {
                callingActivity.runOnUiThread {
                    identityManager.getUserID(object: IdentityHandler{
                        override fun onIdentityId(identityId: String?) {
                            sessionManager
                                    .sync(hashMapOf("provider" to provider!!.displayName, "email" to "test@facebook.com"), identityId)
                                    .right {
                                        loginResultHandler.onComplete(Result.Login("LOGIN", it.egId, provider!!.displayName))
                                    }
                                    .left { err ->
                                        when(err) {
                                            is Result.SyncFailure -> {
                                                // 계정 충돌이 발생했을 경우 충돌 처리 Dialog 창 오픈
                                                callingActivity.runOnUiThread {
                                                    userAllDialog = UserAllDialog(callingActivity, identityId!!, provider.displayName).apply {
                                                        setOnCompleted { loginResultHandler.onComplete(it) }
                                                        setOnCancel {
                                                            signout()
                                                            loginResultHandler.onCancel()
                                                        }
                                                        setOnFail {
                                                            signout()
                                                            loginResultHandler.onFail(it.code)
                                                        }

                                                        if (userLinkMiddleText != null)
                                                            linkSnsDataTextSupplier = userLinkMiddleText
                                                        if (userLinkBottomText != null)
                                                            linkGuestDataTextSupplier = userLinkBottomText
                                                        if (userLoadText != null)
                                                            loadTextSupplier = userLoadText
                                                        if (userGuestText != null)
                                                            guestTextSupplier = userGuestText
                                                    }

                                                    userAllDialog!!.show()
                                                }
                                            }
                                            is Result.Failure -> {
                                                if (identityManager.isUserSignedIn) {
                                                    identityManager.signOut()
                                                }
                                                loginResultHandler.onFail(Fail.ACCOUNT_SYNC_FAIL)
                                            }
                                        }
                                    }
                        }

                        override fun handleError(exception: Exception?) {
                            loginResultHandler.onFail(Fail.ACCOUNT_SYNC_FAIL)
                        }
                    })
                }
            }

            override fun onCancel(activity: Activity?): Boolean {
                back.accept(activity)
                return false
            }
        })
    }

    fun signout() {
        if (identityManager.isUserSignedIn) {
            identityManager.signOut()
        }
    }

    fun logout() {
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
    @Deprecated("Login Dialog 에 종속적인 코드를 포함하고 있어서 오류 가능성이 있음.")
    fun onSwitch() {
        sessionManager.create(identityManager.cachedUserID).right {
            //userResultDialog.show()
        }.left {
            val code: EGException = it as EGException
            identityManager.signOut()
            failCallBack.accept(code.code)
            userAllDialog!!.dismiss()
        }
    }

    /**
     * Sync Dialog 핸들러 메서드.
     * 계정연동 버튼을 눌렀을 경우.
     */
    @Deprecated("Login Dialog 에 종속적인 코드를 포함하고 있어서 오류 가능성이 있음.")
    fun onSync() {
        val provider = identityManager.currentIdentityProvider.displayName
        sessionManager.sync(
                mapOf("provider" to provider), identityManager.cachedUserID, true
        ).right {
            //userResultDialog.show()
        }.left {
            val code: EGException = it as EGException
            identityManager.signOut()
            failCallBack.accept(code.code)
            userAllDialog!!.dismiss()
        }
    }
}