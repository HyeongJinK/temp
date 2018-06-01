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
    public var setUserLinkMiddleText: CustormSupplier<String>? = null
    public var setUserLinkBottomText: CustormSupplier<String>? = null
    public var setUserLoadText: CustormSupplier<String>? = null
    public var setUserGuestText: CustormSupplier<String>? = null

    var userAllDialog: UserAllDialog? = null

    /**
     * 콜백함수
     * */

    public var startFailCallBack: CustomConsumer<Fail> = CustomConsumer {  }
    public var goToLoginFailCallBack: CustomConsumer<Fail> = CustomConsumer {  }
    public var startSuccessCallBack: Runnable = Runnable {  }
    public var goToLoginSuccessCallBack: Runnable = Runnable {  }
    public var clearSuccessCallBack: Runnable = Runnable {  }
    public var back:CustomConsumer<Activity> = CustomConsumer {  }


    val sessionManager: SessionManager by lazy {
        SessionManager(callingActivity)
    }

    val identityManager: IdentityManager by lazy {
        IdentityManager.getDefaultIdentityManager()
    }

    fun setting() {
        userAllDialog!!.closeCallBack = Runnable {
            signout()
        }

        if (setUserLinkMiddleText != null)
            userAllDialog!!.linkSnsDataTextSupplier = setUserLinkMiddleText
        if (setUserLinkBottomText != null)
            userAllDialog!!.linkGuestDataTextSupplier = setUserLinkBottomText

        userAllDialog!!.loadConfirmCallBack = Runnable {
            onSwitch()
        }

        if (setUserLoadText != null)
            userAllDialog!!.loadTextSupplier = setUserLoadText

        userAllDialog!!.guestConfirmCallBack = Runnable {
            onSync()
        }

        if (setUserGuestText != null)
            userAllDialog!!.guestTextSupplier = setUserGuestText

        userAllDialog!!.resultConfirmCallBack = Runnable {
            goToLoginSuccessCallBack.run()
        }
    }

    val complete: (String) -> Unit = {
        identityManager.login(callingActivity, object: DefaultSignInResultHandler() {
            override fun onSuccess(activity: Activity?, provider: IdentityProvider?) {
                callingActivity.runOnUiThread(Runnable {

                    identityManager.getUserID(object: IdentityHandler {
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
                                        when (err) {
                                            is Result.SyncFailure -> {
                                                // 계정 충돌이 발생했을 경우 충돌 처리 Dialog 창 오픈

                                                callingActivity.runOnUiThread(Runnable {
                                                    userAllDialog = UserAllDialog(callingActivity)
                                                    setting()

                                                    userAllDialog!!.show()
                                                })
                                            }
                                            is Result.Failure -> {
                                                if (identityManager.isUserSignedIn) {
                                                    identityManager.signOut()
                                                }
                                                goToLoginFailCallBack.accept(Fail.ACCOUNT_SYNC_FAIL)
                                            }
                                        }
                                    }
                        }
                        override fun handleError(exception: Exception?) {
                            goToLoginFailCallBack.accept(Fail.ACCOUNT_SYNC_FAIL)
                        }
                    })

                })
            }

            override fun onCancel(activity: Activity?): Boolean {
                back.accept(activity!!)
                return false
            }
        })
        startSuccessCallBack.run()
    }

    val fail: (Throwable) -> Unit = { t ->
        val code: EGException = t as EGException
        startFailCallBack.accept(code.code)
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
                                startFailCallBack.accept(Fail.TOKEN_CREATION)
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
        callingActivity.runOnUiThread(Runnable {
            val config = AuthUIConfiguration.Builder()
                    .signInButton(FacebookButton::class.java)
                    .signInButton(GoogleButton::class.java)
                    .userPools(false)
                    .build()
            SignInActivity.startSignInActivity(callingActivity, config)
        })
    }

    public fun goToLogin(config: AuthUIConfiguration) {
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
            //userResultDialog.show()
        }.left {
            val code: EGException = it as EGException
            identityManager.signOut()
            goToLoginFailCallBack.accept(code.code)
            userAllDialog!!.dismiss()
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
            //userResultDialog.show()
        }.left {
            val code: EGException = it as EGException
            identityManager.signOut()
            goToLoginFailCallBack.accept(code.code)
            userAllDialog!!.dismiss()
        }
    }
}