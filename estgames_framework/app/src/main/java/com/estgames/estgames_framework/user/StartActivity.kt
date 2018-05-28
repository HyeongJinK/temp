package com.estgames.estgames_framework.user

import android.content.Context
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import com.amazonaws.mobile.auth.core.IdentityHandler
import com.amazonaws.mobile.auth.core.IdentityManager
import com.estgames.estgames_framework.R
import com.estgames.estgames_framework.common.UserServiceEx
import com.estgames.estgames_framework.core.session.SessionManager
import java.lang.Exception

class StartActivity : AppCompatActivity() {
    val sessionManager: SessionManager by lazy {
        SessionManager(applicationContext)
    }

    val complete: (String) -> Unit = {t ->
        Log.d("LOG-T","---->>>> complete auth $t")
        UserServiceEx.start(this@StartActivity)
        this@StartActivity.finish()
    }

    val fail: (Throwable) -> Unit = {t ->
        Log.d("LOG-T", "---->>> failure error $t")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.start)

        val manager = IdentityManager.getDefaultIdentityManager()
        manager.resumeSession(
                this,
                {result ->
                    if (sessionManager.hasSession) {
                        sessionManager.open().right(complete).left(fail)
                    } else {
                        result.identityManager.getUserID(object : IdentityHandler {
                            override fun handleError(e: Exception?) {

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
}