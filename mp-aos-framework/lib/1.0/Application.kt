package comaf.estgames.ttestasdf

import android.support.multidex.MultiDexApplication
import android.util.Log
import com.amazonaws.mobile.auth.core.IdentityManager
import com.amazonaws.mobile.auth.facebook.FacebookSignInProvider
import com.amazonaws.mobile.auth.google.GoogleSignInProvider
import com.amazonaws.mobile.config.AWSConfiguration
import com.estgames.estgames_framework.core.AndroidUtils
import com.estgames.estgames_framework.core.Configuration
import com.estgames.estgames_framework.core.PlatformContext
import com.estgames.estgames_framework.core.session.PreferenceSessionRepository
import com.estgames.estgames_framework.core.session.SessionRepository
import com.google.android.gms.common.Scopes

/**
 * Created by jupic on 18. 1. 15.
 */
class Application: MultiDexApplication(), PlatformContext {
    companion object {
        private val LOG_TAG: String = Application::class.java.simpleName
    }

    override val configuration: Configuration by lazy {
        Configuration(applicationContext)
    }

    override val deviceId: String
        get() {
            return "${AndroidUtils.obtainDeviceId(applicationContext)}@android"
        }

    override val sessionRepository: SessionRepository by lazy {
        PreferenceSessionRepository(applicationContext)
    }

    override fun onCreate() {
        super.onCreate()
        initialize()
        checkSignature()
        initEgPlatform()
    }

    private fun initEgPlatform() {
        Log.d(LOG_TAG, "Initialized eg-config ${configuration}")
    }

    private fun initialize() {
        var awsCfg = AWSConfiguration(applicationContext)

        if (IdentityManager.getDefaultIdentityManager() == null) {
            var idManager = IdentityManager(applicationContext, awsCfg)
            IdentityManager.setDefaultIdentityManager(idManager)
        }

        FacebookSignInProvider.setPermissions("public_profile")
        GoogleSignInProvider.setPermissions(Scopes.EMAIL, Scopes.PROFILE)

        IdentityManager.getDefaultIdentityManager()
                .addSignInProvider(FacebookSignInProvider::class.java)

        IdentityManager.getDefaultIdentityManager()
                .addSignInProvider(GoogleSignInProvider::class.java)
    }

    private fun checkSignature() {
        Log.d(LOG_TAG, "====>> finger print sha1 by util : ${AndroidUtils.obtainFingerPrint(applicationContext)}")
    }
}

