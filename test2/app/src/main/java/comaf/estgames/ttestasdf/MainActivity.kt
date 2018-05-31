package comaf.estgames.ttestasdf

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
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
import com.estgames.estgames_framework.common.*
import com.estgames.estgames_framework.core.Profile
import com.estgames.estgames_framework.core.Result
import com.estgames.estgames_framework.core.session.SessionManager
import com.estgames.estgames_framework.user.UserAllDialog
import com.estgames.estgames_framework.user.UserLoadDialog
import java.lang.Exception

private val MY_PERMISSIONS_REQUEST_READ_CONTACTS = 1

class MainActivity : AppCompatActivity() {
    lateinit var estCommonFramework: EstCommonFramework
    var uv:UserServiceTest? = null;
    var tt:UserAllDialog? = null;

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

    private  val errorCodeTxt by lazy {
        findViewById<TextView> (R.id.txt_error)
    }
    private val callBack by lazy {
        findViewById<TextView> (R.id.callBack)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        uv = UserServiceTest(this)

        uv!!.failCallBack = CustomConsumer { e ->
            errorCodeTxt.setText(e.name)
        }
        tt = UserAllDialog(this)


        var test0bt: Button = findViewById(R.id.test0bt)
        var test1bt: Button = findViewById(R.id.test1bt)
        var test2bt: Button = findViewById(R.id.test2bt)
        var test3bt: Button = findViewById(R.id.test3bt)

        var startbt: Button = findViewById(R.id.startGame)
        var snsBt: Button = findViewById(R.id.snsBt)
        var clearBt: Button = findViewById(R.id.clearBt)
        var statusBt: Button = findViewById(R.id.statusBt)


        estCommonFramework = EstCommonFramework(this, CustomConsumer {
            test0bt.setText("순서대로, 스타트 API 호출 끝")
        })

        estCommonFramework.estCommonFailCallBack = CustomConsumer {
            t ->
            runOnUiThread(Runnable {
                errorCodeTxt.setText(t.name)
            })
        }

        estCommonFramework.create() //데이터 설정

        //순서대로
        test0bt.setOnClickListener(View.OnClickListener {//estCommonFramework.processShow()
            estCommonFramework.processCallBack = Runnable { callBack.setText("순서대로 종료 콜백 실행") }

            estCommonFramework.processShow();
        })
        //권한
        test1bt.setOnClickListener(View.OnClickListener {
            estCommonFramework.authorityCallBack = Runnable {
                if(ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == -1) {
                    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), MY_PERMISSIONS_REQUEST_READ_CONTACTS)
                }
                callBack.setText("권한 종료 콜백 실행")
            }
            estCommonFramework.authorityShow( )
        })

        test2bt.setOnClickListener(View.OnClickListener {
            estCommonFramework.policyCallBack = Runnable {
                callBack.setText("이용약관 종료 "+ estCommonFramework.contractService()+ "  " + estCommonFramework.contractPrivate())
            }

            estCommonFramework.policyShow()
        })

        test3bt.setOnClickListener(View.OnClickListener {
            estCommonFramework.bannerCallBack = Runnable {
                callBack.setText("bannerCallBack")
            }
            estCommonFramework.bannerShow()
        })

        startbt.setOnClickListener(View.OnClickListener {
            uv!!.startSuccessCallBack = Runnable { callBack.setText("계정 생성됨") }
            uv!!.createUser()
        })

        statusBt.setOnClickListener(View.OnClickListener {
            userIdentity()
        })

        snsBt.setOnClickListener(View.OnClickListener {
            uv!!.goToLoginSuccessCallBack = Runnable { callBack.setText("계정연동 종료") }
            uv!!.back = CustomConsumer<Activity> { activity ->
                activity.startActivity(Intent(activity, MainActivity::class.java))
            }
            uv!!.goToLogin()
        })

        clearBt.setOnClickListener(View.OnClickListener {
            uv!!.logout()
        })
    }



    val sessionManager: SessionManager by lazy {
        SessionManager(applicationContext)
    }

    private fun userIdentity() {
        val profile:Profile = sessionManager.profile
        val token = sessionManager.token

        txtStatus.text = profile.provider
        txtUserId.text = "EG ID :" + profile.egId
        txtPrincipal.text = "Principal :" +profile.userId
        txtEgToken.text = "EG Token :" + token.egToken
        txtRefreshToken.text = "Refresh Token :" + token.refreshToken
    }
}
