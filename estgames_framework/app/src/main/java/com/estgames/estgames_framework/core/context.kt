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
import java.util.concurrent.Callable
import java.util.concurrent.Executors
import java.util.concurrent.Future


/**
 * EG Platform 서비스 설정 정보 클래스
 */
abstract class Configuration {
    abstract val clientId: String
    abstract val secret: String
    abstract val region: String

    class Option() {
        var resourceId: Int? = null

        internal var clientId: String? = null
        internal var secret: String? = null
        internal var region: String? = null

        internal var lazyClientId: LazyOption<String>? = null
        internal var lazySecret: LazyOption<String>? = null
        internal var lazyRegion: LazyOption<String>? = null

        internal val isLazy: Boolean get() {
            return lazyClientId != null || lazySecret != null || lazyRegion != null
        }

        fun clientId(clientId: String): Option {
            this.clientId = clientId
            return this
        }

        fun clientId(clientId: LazyOption<String>): Option  {
            this.lazyClientId = clientId
            return this
        }

        fun secret(secret: String): Option  {
            this.secret = secret
            return this
        }

        fun secret(secret: LazyOption<String>): Option  {
            this.lazySecret = secret
            return this
        }

        fun region(region: String): Option  {
            this.region = region
            return this
        }

        fun region(region: LazyOption<String>): Option  {
            this.lazyRegion = region
            return this
        }
    }

    companion object {
        private const val RESOURCE_IDENTIFIER = "egconfiguration"

        @JvmStatic
        fun build(context: Context, option: Configuration.Option): Configuration {
            val resourceId = option.resourceId ?: context.resources.getIdentifier(RESOURCE_IDENTIFIER, "raw", context.packageName)
            var buf = StringBuilder()
            Scanner(context.resources.openRawResource(resourceId)).use { scan -> scan.forEach { buf.append(it) } }
            val default = JSONObject(buf.toString())

            return if (option.isLazy) {
                LazyConfiguration(
                        option.lazyClientId ?: LazyOption { default.getJSONObject("Client").getString("ClientId") },
                        option.lazySecret ?: LazyOption { default.getJSONObject("Client").getString("Secret") },
                        option.lazyRegion ?: LazyOption { default.getJSONObject("Client").getString("Region") }
                );
            } else {
                SimpleConfiguration(
                        option.clientId ?: default.getJSONObject("Client").getString("ClientId"),
                        option.secret ?: default.getJSONObject("Client").getString("Secret"),
                        option.region ?: default.getJSONObject("Client").getString("Region")
                )
            }
        }

        @JvmStatic fun build(context: Context): Configuration {
            return build(context, Configuration.Option())
        }
    }
}

internal class SimpleConfiguration(
        override val clientId: String,
        override val secret: String,
        override val region: String
): Configuration()

internal class LazyConfiguration(clientId: LazyOption<String>, secret: LazyOption<String>, region: LazyOption<String>): Configuration() {
    private val lazyClientId: Future<String>
    private val lazySecret: Future<String>
    private val lazyRegion: Future<String>

    init {
        val executor = Executors.newFixedThreadPool(3)
        lazyClientId = executor.submit(Callable { clientId.value() })
        lazySecret = executor.submit(Callable { secret.value() })
        lazyRegion = executor.submit(Callable { region.value() })
        executor.shutdown()
    }

    override val clientId: String by lazy {
        lazyClientId.get()
    }

    override val secret: String by lazy {
        lazySecret.get()
    }

    override val region: String by lazy {
        lazyRegion.get()
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

interface Initializer {
    val configuration: Configuration
    fun init(option: Configuration.Option)
}

internal class DefaultInitializer(context: Context, option: Configuration.Option): Initializer {
    override val configuration: Configuration = Configuration.build(context, option);
    override fun init(option: Configuration.Option) {}
}

class LazyInitializer(private val context: Context): Initializer {
    private val proxy = object: Configuration() {
        var config: Configuration? = null;
        override val clientId: String
            get() = config?.clientId ?: throw Fail.CLIENT_NOT_INITIALIZED.with("Client configuration is not initialized!! - check [Client ID]")

        override val secret: String
            get() = config?.secret ?: throw Fail.CLIENT_NOT_INITIALIZED.with("Client configuration is not initialized!! - check [Client Secret]")

        override val region: String
            get() = config?.region ?: throw Fail.CLIENT_NOT_INITIALIZED.with("Client configuration is not initialized!! - check [Client Region]")
    }

    override val configuration: Configuration = proxy

    override fun init(option: Configuration.Option) {
        this.proxy.config = Configuration.build(context, option)
    }
}

/**
 * AWS 설정을 포함한 EG Platform Context Delegate 구현체
 */
class AwsPlatformContext(context: Context, initializer: Initializer): PlatformContext {
    constructor(context: Context): this(context, Configuration.Option())
    constructor(context: Context, option: Configuration.Option): this(context, DefaultInitializer(context, option))

    init {
        // AwsConfiguration 초기화 및 생성
        var awsCfg = AWSConfiguration(context);

        // Cognito 인증을 위한 Default IdentityManager 설정
        if (IdentityManager.getDefaultIdentityManager() == null) {
            IdentityManager.setDefaultIdentityManager(IdentityManager(context.applicationContext, awsCfg));
        }

        FacebookSignInProvider.setPermissions("public_profile", "email");
        GoogleSignInProvider.setPermissions(Scopes.EMAIL, Scopes.PROFILE);

        IdentityManager.getDefaultIdentityManager().addSignInProvider(FacebookSignInProvider::class.java)
        IdentityManager.getDefaultIdentityManager().addSignInProvider(GoogleSignInProvider::class.java)
    }

    override val configuration: Configuration = initializer.configuration
    override val deviceId: String = "${AndroidUtils.obtainDeviceId(context.applicationContext)}@android"
    override val sessionRepository: SessionRepository = PreferenceSessionRepository(context.applicationContext)
}
