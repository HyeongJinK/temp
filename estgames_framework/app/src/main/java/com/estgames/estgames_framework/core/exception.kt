package com.estgames.estgames_framework.core


open class EGException: Exception {
    val code: Fail
    constructor(code: Fail, message: String): super("CODE [$code] - $message") { this.code = code }
    constructor(code: Fail, message: String, cause: Throwable): super("CODE [$code] - $message", cause) { this.code = code }
}


enum class Fail(private val serverCode: String? = null) {
    START_API_NOT_CALL,

    TOKEN_EMPTY,
    TOKEN_CREATION,
    TOKEN_INVALID("session.invalid"),
    TOKEN_EXPIRED("session.expired"),

    CLIENT_UNKNOWN_PROVIDER("api.provider"),
    CLIENT_NOT_REGISTERED("app.none"),

    API_REQUEST_FAIL,
    API_ACCESS_DENIED("auth.forbidden"),
    API_OMITTED_PARAMETER("api.param"),
    API_UNSUPPORTED_METHOD("api.method"),
    API_BAD_REQUEST("api.request"),
    API_INCOMPATIBLE_VERSION("api.version"),
    API_CHARACTER_INFO,

    ACCOUNT_NOT_EXIST("account.none"),
    ACCOUNT_ALREADY_EXIST("account.duplicate"),
    ACCOUNT_INVALID_PROPERTY("account.value"),
    ACCOUNT_SYNC_FAIL("account.sync"),

    SIGN_AWS_LOGIN_VIEW,
    SIGN_GOOGLE_SDK,
    SIGN_FACEBOOK_SDK,
    SIGN_AWS_SESSION,
    SIGN_SWITCH_OR_SYNC;

    companion object {
        @JvmStatic fun resolve(code: String, message: String): EGException {
            val codes = Fail.values().filter { f ->
                if (code == f.name) {
                    return@filter true
                } else {
                    return@filter code == f.serverCode
                }
            }
            return codes[0].with(message)
        }

        @JvmStatic fun resolve(code: String, message: String, cause: Throwable): EGException {
            val codes = Fail.values().filter { f ->
                if (code == f.name) {
                    return@filter true
                } else {
                    return@filter code == f.serverCode
                }
            }
            return codes[0].with(message, cause)
        }
    }

    fun with(message: String): EGException {
        return EGException(this, message)
    }

    fun with(message: String, cause: Throwable): EGException {
        return EGException(this, message, cause)
    }
}
