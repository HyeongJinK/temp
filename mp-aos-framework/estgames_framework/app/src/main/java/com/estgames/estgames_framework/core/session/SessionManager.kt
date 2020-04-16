package com.estgames.estgames_framework.core.session

import android.content.Context
import com.estgames.estgames_framework.core.*
import org.json.JSONException
import org.json.JSONObject
import java.util.*
import java.util.concurrent.Callable
import java.util.concurrent.Executors
import kotlin.collections.HashMap


class SessionManager(context:Context) {
    private val _platform = context.applicationContext as PlatformContext
    private val _sessionRepo = _platform.sessionRepository

    val hasSession: Boolean get() { return _platform.sessionRepository.hasSession }

    val profile: Profile? get() {
        val s = _platform.sessionRepository.session
        return when(s) {
            is Profile -> s
            else -> null
        }
    }

    val token: Token? get() {
        val s = _platform.sessionRepository.session
        return when(s) {
            is Token -> s
            else -> null
        }
    }

    fun create(principal:String): Either<EGException, String> {
        val executor = Executors.newSingleThreadExecutor()
        val result = executor.submit(Callable<Either<EGException, Session.Complete>> {
            try {
                val token = Api.Token(
                        _platform.configuration.clientId,
                        _platform.configuration.secret,
                        _platform.configuration.region,
                        _platform.deviceId,
                        principal).json()
                val me = Api.Me(token.getString("eg_token")).json()
                val provider = me.getJSONObject("profile").get("provider")
                val email = me.getJSONObject("profile").get("email")

                return@Callable Right(Session.Complete(
                        egToken = token.getString("eg_token"),
                        refreshToken = token.getString("refresh_token"),
                        egId = me.getString("eg_id"),
                        principal = me.getString("principal_of_client"),
                        provider = if (provider.equals(null)) null else provider as String,
                        email = if(email.equals(null)) null else email as String,
                        userId = me.getString("user_id")
                ))
            } catch (e: EGException) {
                return@Callable Left(e)
            }
        }).get()
        executor.shutdown()

        return result.rightTo { s ->
            _sessionRepo.session = s
            return@rightTo s.egToken
        }
    }

    fun open(): Either<EGException, String> {
        val session = _sessionRepo.session
        return when(session) {
            is Token -> {
                val executor = Executors.newSingleThreadExecutor()
                val result = executor.submit(Callable<Either<EGException, Session.Complete>> {
                    try {
                        val token = Api.Refresh(
                                _platform.configuration.clientId,
                                _platform.configuration.secret,
                                _platform.configuration.region,
                                _platform.deviceId,
                                session.refreshToken,
                                session.egToken
                        ).json()
                        val me = Api.Me(token.getString("eg_token")).json()
                        val provider = me.getJSONObject("profile").get("provider")
                        val email = me.getJSONObject("profile").get("email")

                        return@Callable Right(Session.Complete(
                                egToken = token.getString("eg_token"),
                                refreshToken = session.refreshToken,
                                egId = me.getString("eg_id"),
                                principal = me.getString("principal_of_client"),
                                provider = if (provider.equals(null)) null else provider as String,
                                email = if(email.equals(null)) null else email as String,
                                userId = me.getString("user_id")
                        ))
                    } catch (e: EGException) {
                        if (e.code == Fail.TOKEN_INVALID || e.code == Fail.API_ACCESS_DENIED) {
                            _sessionRepo.revoke()
                        }
                        return@Callable Left(e)
                    }
                }).get()
                executor.shutdown()

                result.rightTo { s ->
                    _sessionRepo.session = s
                    return@rightTo s.egToken
                }
            }
            else -> {
                Left(Fail.TOKEN_EMPTY.with("There is any session."))
            }
        }
    }

    fun sync(data: Map<String, Any>, principal: String? = null, force: Boolean = false): Either<Result, Result.SyncComplete> {
        val session = _sessionRepo.session
        return when(session) {
            is Session.Complete -> {
                val executor = Executors.newSingleThreadExecutor()
                val result = executor.submit(Callable<Either<Result, Result.SyncComplete>> {
                    try {
                        val msg = Api.Synchronize(session.egToken, principal?: session.principal, data, force).json()
                        val status = msg.getString("status")

                        if (status.toUpperCase() == "COMPLETE") {
                            return@Callable Right(Result.SyncComplete(
                                    egId = msg.getString("eg_id"),
                                    from = msg.getString("from"),
                                    to = msg.getString("to"),
                                    data = msg.getJSONObject("data").toMap(),
                                    at = Date()
                            ))
                        } else {
                            return@Callable Left(Result.SyncFailure(
                                    egId = msg.getString("duplicated"),
                                    message = msg.getString("message")
                            ))
                        }
                    } catch (e: Exception) {
                        return@Callable Left(Result.Failure(
                                code="client.unknown", message=e.message!!, cause=e
                        ))
                    }
                })
                executor.shutdown()
                result.get().rightTo {
                    val session = _sessionRepo.session as Session.Complete

                    _sessionRepo.session = Session.Complete(
                            egToken = session.egToken,
                            refreshToken = session.refreshToken,
                            egId = it.egId,
                            principal = it.to,
                            provider = if (it.data.get("provider") != null) it.data.get("provider") as String else null,
                            email = if(it.data.get("email") != null) it.data.get("email") as String else null,
                            userId = session.userId
                    )
                    return@rightTo it
                }
            }
            else -> Left(Result.Failure(
                    code="client.no_session", message="There is any valid session."
            ))
        }
    }

    fun expire(): Either<EGException, String> {
        val session = _sessionRepo.session
        return when (session) {
            is Token -> {
                val executor = Executors.newSingleThreadExecutor()
                val result = executor.submit(Callable<Either<EGException, String>> {
                    try {
                        val msg = Api.Expire(session.egToken).json()
                        return@Callable Right(msg.getString("logout_time"))
                    } catch (e: EGException) {
                        return@Callable Left(e)
                    }
                })
                executor.shutdown()

                result.get()
            }
            else -> Right("expired")
        }
    }
    //로그아웃 정보는 남는다.
    fun signOut(): Either<EGException, String> {
        return expire().rightTo {
            _sessionRepo.revoke()
            return@rightTo "sign out"
        }
    }
    // 탈퇴 개념 캐릭터 정보도 날아간다
    fun revoke(): Either<EGException, String> {
        val session = _sessionRepo.session
        return when(session) {
            is Token -> {
                val executor = Executors.newSingleThreadExecutor()
                val result = executor.submit(Callable<Either<EGException, String>> {
                    try {
                        val msg = Api.Abandon(
                                session.egToken,
                                _platform.configuration.clientId,
                                _platform.configuration.secret,
                                _platform.configuration.region).json()
                        return@Callable Right(msg.getString("code"))
                    } catch (e: EGException) {
                        return@Callable Left(e)
                    }
                })
                executor.shutdown()
                result.get().rightTo {code ->
                    _sessionRepo.revoke()
                    return@rightTo code
                }
            }
            else -> Right("revoked")
        }
    }

    private fun Api.json(): JSONObject {
        try {
            val r = this.invoke()
            try {
                if (r.status == 200) {
                    return JSONObject(String(r.content, Charsets.UTF_8))
                } else {
                    var msg = JSONObject(String(r.content, Charsets.UTF_8))
                    throw Fail.resolve(msg.getString("code"), msg.getString("message"))
                }
            } catch (e: JSONException) {
                    throw Fail.API_UNKNOWN_RESPONSE.with("API Request Fail. - http response status : ${r.status}, message: ${r.message}")
            }
        } catch (e: EGException) {
            throw e
        } catch (e: Exception) {
            throw Fail.API_REQUEST_FAIL.with("API Request Failed!! : ${e.message}", e)
        }
    }

    private fun JSONObject.toMap(): Map<String, Any> {
        var map = HashMap<String, Any>()
        this.keys().forEach {k -> map.put(k as String, this.get(k)) }
        return map
    }
}