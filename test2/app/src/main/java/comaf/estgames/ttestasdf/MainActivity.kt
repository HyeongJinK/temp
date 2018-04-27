package comaf.estgames.ttestasdf

import android.app.Activity
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.Toast
import com.estgames.estgames_framework.authority.AuthorityDialog
import com.estgames.estgames_framework.banner.BannerDialog
import com.estgames.estgames_framework.policy.PolicyDialog
//import com.amazonaws.mobile.auth.core.IdentityManager
//import com.amazonaws.mobile.auth.core.IdentityHandler
import com.estgames.estgames_framework.core.session.SessionManager
import java.lang.Exception

class MainActivity : AppCompatActivity() {
    val sessionManager: SessionManager by lazy {
        SessionManager(applicationContext)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        var test1bt: Button = findViewById(R.id.test1bt);
        var test2bt: Button = findViewById(R.id.test2bt);
        var test3bt: Button = findViewById(R.id.test3bt);
        var startbt: Button = findViewById(R.id.startGame);

        val test1: AuthorityDialog = AuthorityDialog(this, getSharedPreferences("auth", Activity.MODE_PRIVATE));
        val test2: PolicyDialog = PolicyDialog(this);
        val test3: BannerDialog = BannerDialog(this, getSharedPreferences("banner", Activity.MODE_PRIVATE));

        test1bt.setOnClickListener(View.OnClickListener { test1.show() })
        test2bt.setOnClickListener(View.OnClickListener { test2.show() })
        test3bt.setOnClickListener(View.OnClickListener { test3.show() })

//        startbt.setOnClickListener(View.OnClickListener {
//            val manager = IdentityManager.getDefaultIdentityManager()
//            manager.resumeSession(
//                    this,
//                    {result ->
//                        if (sessionManager.hasSession) {
//                            sessionManager.open().right(complete).left(fail)
//                        } else {
//                            result.identityManager.getUserID(object : IdentityHandler {
//                                override fun handleError(e: Exception?) {
//                                    Toast.makeText(this@MainActivity, "Error !! $e", Toast.LENGTH_SHORT)
//                                }
//
//                                override fun onIdentityId(identityId: String?) {
//                                    sessionManager.create(principal=identityId!!).right(complete).left(fail)
//                                }
//                            })
//                        }
//                    },
//                    200
//            )
//        })
    }

    val complete: (String) -> Unit = {t ->
        Toast.makeText(this@MainActivity, "Success $t", Toast.LENGTH_SHORT)
    }

    val fail: (Throwable) -> Unit = {t ->
        Toast.makeText(this@MainActivity, "Error !! $t", Toast.LENGTH_SHORT)
    }
}
