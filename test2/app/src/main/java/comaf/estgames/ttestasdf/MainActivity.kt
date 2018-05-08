package comaf.estgames.ttestasdf

import android.app.Activity
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.amazonaws.mobile.auth.core.DefaultSignInResultHandler
import com.amazonaws.mobile.auth.core.IdentityHandler
import com.amazonaws.mobile.auth.core.IdentityManager
import com.amazonaws.mobile.auth.core.IdentityProvider
import com.amazonaws.mobile.auth.facebook.FacebookButton
import com.amazonaws.mobile.auth.google.GoogleButton
import com.amazonaws.mobile.auth.ui.AuthUIConfiguration
import com.amazonaws.mobile.auth.ui.SignInActivity
import com.estgames.estgames_framework.common.EstCommonFramework
import com.estgames.estgames_framework.core.Result
import com.estgames.estgames_framework.core.Session
import com.estgames.estgames_framework.core.session.SessionManager
import com.estgames.estgames_framework.user.UserLoadDialog
import java.lang.Exception


class MainActivity : AppCompatActivity() {
    lateinit var estCommonFramework: EstCommonFramework
    var uv:UserSerivce? = null;

    private val txtStatus: TextView by lazy {
        findViewById<TextView>(R.id.txt_status)
    }

    private val txtUserId: TextView by lazy {
        findViewById<TextView>(R.id.txt_user_id)
    }

    private val txtPrincipal: TextView by lazy {
        findViewById<TextView>(R.id.txt_principal)
    }

    private val txtEgToken: TextView by lazy {
        findViewById<TextView>(R.id.txt_eg_token)
    }

    private val txtRefreshToken by lazy {
        findViewById<TextView>(R.id.txt_refresh_token)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)






        estCommonFramework = EstCommonFramework(this);



        //uv = UserSerivce(this, this@MainActivity, applicationContext)
        uv = UserSerivce(this, applicationContext)
        var test1bt: Button = findViewById(R.id.test1bt)
        var test2bt: Button = findViewById(R.id.test2bt)
        var test3bt: Button = findViewById(R.id.test3bt)
        var startbt: Button = findViewById(R.id.startGame)
        var snsBt: Button = findViewById(R.id.snsBt)
        var clearBt: Button = findViewById(R.id.clearBt)
        var statusBt: Button = findViewById(R.id.statusBt)

//        val test1: AuthorityDialog = AuthorityDialog(this, getSharedPreferences("auth", Activity.MODE_PRIVATE));
//        val test2: PolicyDialog = PolicyDialog(this);
//        val test3: BannerDialog = BannerDialog(this, getSharedPreferences("banner", Activity.MODE_PRIVATE));

        test1bt.setOnClickListener(View.OnClickListener {estCommonFramework.authorityShow()})
        test2bt.setOnClickListener(View.OnClickListener {estCommonFramework.policyShow()})
        test3bt.setOnClickListener(View.OnClickListener {estCommonFramework.bannerShow()})

        startbt.setOnClickListener(View.OnClickListener {
            uv!!.createUser()
            //createUser()
        })

        statusBt.setOnClickListener(View.OnClickListener {
            userIdentity()
        })

        snsBt.setOnClickListener(View.OnClickListener {
            //login()
            uv!!.goToLogin()
        })

        clearBt.setOnClickListener(View.OnClickListener {
            //logout()
            uv!!.logout()
        })

//        var testBt : Button = findViewById(R.id.testBt)
//
//        testBt.setOnClickListener(View.OnClickListener {
//            detectEvent()
//        })

        //detectEvent()
    }



    val sessionManager: SessionManager by lazy {
        SessionManager(applicationContext)
    }
    val identityManager: IdentityManager by lazy {
        IdentityManager.getDefaultIdentityManager()
    }

    val complete: (String) -> Unit = {t ->
        //MainActivity.start(this@MainActivity)
        //this@MainActivity.finish()

        // 코그니토를 통한 로그인 프로세스.
        identityManager.login(this, object: DefaultSignInResultHandler() {
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
                                    //충돌없이 성공했을 경우
                                }
                                .left { err ->
                                    var event:Result = err
                                    when (event) {
                                        is Result.SyncFailure -> {
                                            var test: UserLoadDialog = UserLoadDialog(this@MainActivity)
                                            test.show()
                                        }
                                        is Result.Failure -> {
                                            if (identityManager.isUserSignedIn) {
                                                identityManager.signOut()
                                            }
                                            Toast.makeText(
                                                    this@MainActivity,
                                                    "Error !!: ${event.cause}",
                                                    Toast.LENGTH_SHORT
                                            ).show()
                                        }
                                    }
                                }
                    }
                    override fun handleError(exception: Exception?) {}
                })
            }

            override fun onCancel(activity: Activity?): Boolean {
                //MainActivity.start(activity!!)
                return false
            }
        })
    }

    val fail: (Throwable) -> Unit = {t ->
        Toast.makeText(this@MainActivity, "Error !! $t", Toast.LENGTH_SHORT)
    }

    private fun createUser() {
        val manager = IdentityManager.getDefaultIdentityManager()
        manager.resumeSession(
                this,
                {result ->
                    if (sessionManager.hasSession) {
                        sessionManager.open().right(complete).left(fail)
                    } else {
                        result.identityManager.getUserID(object : IdentityHandler {
                            override fun handleError(e: Exception?) {
                                Toast.makeText(this@MainActivity, "Error !! $e", Toast.LENGTH_SHORT)
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

    private fun login() {
        val config = AuthUIConfiguration.Builder()
                .signInButton(FacebookButton::class.java)
                .signInButton(GoogleButton::class.java)
                .userPools(false)
                .build()
        SignInActivity.startSignInActivity(this, config)
    }

    private fun logout() {
        //로그아웃
        //val session = sessionManager.session as Session.Complete
        if (identityManager.isUserSignedIn) {
            identityManager.signOut()
        }
//                sessionManager.revoke()
        sessionManager.signOut()
//        startActivity(
//                Intent(this@MainActivity, SplashActivity::class.java).apply {
//                    flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
//                }
//        )
    }

    private fun userIdentity() {

        try {
            val session = sessionManager.session as Session.Complete

            if (session != null) {
                txtStatus.text = if (session.provider != null)
                    "${getText(R.string.txt_status_signed)} : ${session.provider}"
                else
                    "${getText(R.string.txt_status_unsigned)} : ${getText(R.string.txt_provider_guest)}"

                txtUserId.text = "EG ID : ${session.egId}"
                txtPrincipal.text = "Principal : ${session.principal}"
                txtEgToken.text = "EG Token : ${session.egToken}"
                txtRefreshToken.text = "Refresh Token : ${session.refreshToken}"
            }
        } catch (e: Exception) {
            txtStatus.text = ""
            txtUserId.text = "EG ID :"
            txtPrincipal.text = "Principal :"
            txtEgToken.text = "EG Token :"
            txtRefreshToken.text = "Refresh Token :"
        }
    }


    companion object {
        const val ARGUMENT_EVENT = "event.object"
    }

    /**
     * 계정 연동 실패 이벤트 확인
     * 계정 연동 충돌이 발생한경우 충돌 처리 Dialog 창을 띄워준다.
     */
    private fun detectEvent() {
        val event = intent.getSerializableExtra(ARGUMENT_EVENT)
        println("event: $event")
        when (event) {
            is Result.SyncFailure -> {
                println("aksdjflksadjf")
                // 계정 충돌이 발생했을 경우 충돌 처리 Dialog 창 오픈
                Toast.makeText(
                        this@MainActivity,
                        "충돌 !!",
                        Toast.LENGTH_SHORT
                ).show()
//                SyncDialogFragment
//                        .newDialog(event.egId, "I am pooh")
//                        .apply {
//                            listener = this@MainActivity
//                        }.show(supportFragmentManager, "SyncDialog")
            }
            is Result.Failure -> {
                if (identityManager.isUserSignedIn) {
                    identityManager.signOut()
                }
                Toast.makeText(
                        this@MainActivity,
                        "Error !!: ${event.cause}",
                        Toast.LENGTH_SHORT
                ).show()
            }
        }
    }
}
