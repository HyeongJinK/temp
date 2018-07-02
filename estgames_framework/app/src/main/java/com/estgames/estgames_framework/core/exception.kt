package com.estgames.estgames_framework.core


open class EGException: Exception {
    val code: Fail
    constructor(code: Fail, message: String): super("CODE [$code] - $message") { this.code = code }
    constructor(code: Fail, message: String, cause: Throwable): super("CODE [$code] - $message", cause) { this.code = code }
}


enum class Fail(private val serverCode: String? = null) {
    START_API_NOT_CALL,         // start api 호출 실패
    START_API_DATA_FAIL,        // client process description data 오류
    START_API_DATA_INIT,        // client process description 초기화 실패

    PROCESS_CONTRACT_DENIED,    // 약관 동의 거부

    TOKEN_EMPTY,                                               // 토큰 없음
    TOKEN_CREATION,                                            // 토큰 생성 실패
    TOKEN_INVALID("session.invalid"),           // 유효하지 않은 토큰
    TOKEN_EXPIRED("session.expired"),           // 만료된 토큰

    CLIENT_NOT_INITIALIZED,    // 클라이언트 정보가 초기화 되지 않음.
    CLIENT_UNKNOWN_PROVIDER("api.provider"),    // 연계할 수 없는 프로바이더
    CLIENT_NOT_REGISTERED("app.none"),           // 등록되지 않은 클라이언트

    API_REQUEST_FAIL,                                           // MP API 요청 실패
    API_ACCESS_DENIED("auth.forbidden"),         // API 접근 권한 없음
    API_OMITTED_PARAMETER("api.param"),          // API 파라미터가 누락됨
    API_UNSUPPORTED_METHOD("api.method"),        // 허용되지 않은 메소드로 요청
    API_BAD_REQUEST("api.request"),               // 잘못된 API 요청
    API_INCOMPATIBLE_VERSION("api.version"),     // API 버전 호환 안됨
    API_CHARACTER_INFO,                                         // 캐릭터 정보 조회 실패
    API_UNKNOWN_RESPONSE,                                       // API 응답을 변환 할 수 없음

    ACCOUNT_NOT_EXIST("account.none"),            // 계정정보 없음
    ACCOUNT_ALREADY_EXIST("account.duplicate"),  // 이미 등록된 계정임
    ACCOUNT_INVALID_PROPERTY("account.value"),   // 유효하지 않은 계정 속성
    ACCOUNT_SYNC_FAIL("account.sync"),             // 계정연동 실패

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
