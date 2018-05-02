package comaf.estgames.ttestasdf

import android.app.Activity
import android.content.Context
import android.widget.Toast
import com.amazonaws.mobile.auth.core.*
import com.amazonaws.mobile.auth.facebook.FacebookButton
import com.amazonaws.mobile.auth.google.GoogleButton
import com.amazonaws.mobile.auth.ui.AuthUIConfiguration
import com.amazonaws.mobile.auth.ui.SignInActivity
import com.estgames.estgames_framework.core.session.SessionManager
import java.lang.Exception

/**
 * Created by mp on 2018. 5. 2..
 */
public class UserSerivce constructor(callingActivity: Activity, activity:Context, app: Context) {
    var app = app
    var activety = activity
    var callingActivity = callingActivity

    val sessionManager: SessionManager by lazy {
        SessionManager(activety)
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
                                .right {  }
                                .left { }
                    }
                    override fun handleError(exception: Exception?) {}
                })
            }

            override fun onCancel(activity: Activity?): Boolean {
                return false
            }
        })
    }

    val fail: (Throwable) -> Unit = {t ->
        Toast.makeText(activety, "Error !! $t", Toast.LENGTH_SHORT)
    }

    public fun createUser() {
        val manager = IdentityManager.getDefaultIdentityManager()
        manager.resumeSession(
                callingActivity,
                { result ->
                    if (sessionManager.hasSession) {
                        //sessionManager.open().right(complete).left(fail)
                    } else {
                        result.identityManager.getUserID(object : IdentityHandler {
                            override fun handleError(e: Exception?) {
                                Toast.makeText(activety, "Error !! $e", Toast.LENGTH_SHORT)
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

    public fun login() {
        val config = AuthUIConfiguration.Builder()
                .signInButton(FacebookButton::class.java)
                .signInButton(GoogleButton::class.java)
                .userPools(false)
                .build()
        SignInActivity.startSignInActivity(activety, config)
    }

    public fun logout() {
        val sessionManager = SessionManager(activety)
        val identityManager = IdentityManager.getDefaultIdentityManager()

        if (identityManager.isUserSignedIn) {
            identityManager.signOut()
        }
        sessionManager.signOut()
    }


}