package com.estgames.estgames_framework.core

import android.content.Context
import com.amazonaws.mobile.auth.core.IdentityManager
import com.amazonaws.mobile.auth.facebook.FacebookSignInProvider
import com.amazonaws.mobile.auth.google.GoogleSignInProvider
import com.amazonaws.mobile.config.AWSConfiguration
import com.estgames.estgames_framework.core.session.PreferenceSessionRepository
import com.estgames.estgames_framework.core.session.SessionRepository
import com.google.android.gms.common.Scopes

import java.util.*
import org.json.JSONObject


/**
 * EG Platform 서비스 설정 정보 클래스
 */
class Configuration private constructor(context:Context, config:JSONObject) {
    companion object {
        private const val RESOURCE_IDENTIFIER = "egconfiguration"

        fun getResourceIdentifier(context: Context): Int {
            return context.resources.getIdentifier(RESOURCE_IDENTIFIER, "raw", context.packageName)
        }

        private fun parseConfig(context: Context, resourceId:Int): JSONObject {
            var scan = Scanner(context.resources.openRawResource(resourceId))
            var buf = StringBuilder()
            scan.forEach { buf.append(it) }
            scan.close()

            return JSONObject(buf.toString())
        }
    }

    constructor(context: Context): this(context, getResourceIdentifier(context))

    constructor(context: Context, resourceId: Int): this(context, parseConfig(context, resourceId))


    private val context = context
    private val config = config

    val clientId by lazy {
        config.getJSONObject("Client").getString("ClientId")
    }

    val secret by lazy {
        config.getJSONObject("Client").getString("Secret")
    }

    val region by lazy {
        config.getJSONObject("Client").getString("Region")
    }
}

/**
 * EG Platform 서비스를 위한 Context Interface
 */
interface PlatformContext {
    val configuration: Configuration
    val deviceId: String
    val sessionRepository: SessionRepository
}

/**
 * AWS 설정을 포함한 EG Platform Context Delegate 구현체
 */
class AwsPlatformContext(context: Context): PlatformContext{
    init {
        // AwsConfiguration 초기화 및 생성
        var awsCfg = AWSConfiguration(context);

        // Cognito 인증을 위한 Default IdentityManager 설정
        if (IdentityManager.getDefaultIdentityManager() == null) {
            IdentityManager.setDefaultIdentityManager(IdentityManager(context.applicationContext, awsCfg));
        }

        FacebookSignInProvider.setPermissions("public_profile");
        GoogleSignInProvider.setPermissions(Scopes.EMAIL, Scopes.PROFILE);

        IdentityManager.getDefaultIdentityManager().addSignInProvider(FacebookSignInProvider::class.java)
        IdentityManager.getDefaultIdentityManager().addSignInProvider(GoogleSignInProvider::class.java)
    }

    override val configuration: Configuration = Configuration(context.applicationContext)
    override val deviceId: String = "${AndroidUtils.obtainDeviceId(context.applicationContext)}@android"
    override val sessionRepository: SessionRepository = PreferenceSessionRepository(context.applicationContext)
}