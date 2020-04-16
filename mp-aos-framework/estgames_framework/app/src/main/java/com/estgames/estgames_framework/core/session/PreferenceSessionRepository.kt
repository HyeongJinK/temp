package com.estgames.estgames_framework.core.session

import android.content.Context

import android.util.Base64
import com.estgames.estgames_framework.core.Configuration
import com.estgames.estgames_framework.core.Session
import com.estgames.estgames_framework.core.Token
import java.io.*

class PreferenceSessionRepository(context:Context, private val configuration: Configuration): SessionRepository {
    companion object {
        private const val SESSION_FILE = "eg_platform_session.xml"
        private const val SESSION_OBJECT = "%s.session"
        private const val TOKEN_AUTHORITY = "%s.token.authority"
        private const val TOKEN_ACCESS = "%s.token.access"
    }

    private val _pref = context.getSharedPreferences(SESSION_FILE, Context.MODE_PRIVATE)

    private val _sessionKey by lazy {
        String.format(SESSION_OBJECT, configuration.region)
    }

    private val _tokenAuthKey by lazy {
        String.format(TOKEN_AUTHORITY, configuration.region)
    }

    private val _tokenAccessKey by lazy {
        String.format(TOKEN_ACCESS, configuration.region)
    }

    private fun incompleteSession(): Session {
        val authToken = _pref.getString(_tokenAuthKey, null)
        val accessToken = _pref.getString(_tokenAccessKey, null)

        if (authToken != null && accessToken != null) {
            return Session.Incomplete(egToken = accessToken, refreshToken = authToken)
        }

        return Session.Empty
    }

    override val hasSession: Boolean
        get() {
            val hasSessionObj = _pref.getString(_sessionKey, null) != null
            val hasTokenKey = _pref.getString(_tokenAuthKey, null) != null && _pref.getString(_tokenAccessKey, null) != null
            return hasSessionObj || hasTokenKey
        }

    override var session: Session
        get() {
            val sessionString = _pref.getString(_sessionKey, null)

            return if (sessionString != null) {
                try {
                    ObjectInputStream(ByteArrayInputStream(Base64.decode(sessionString, 0))).use { ois ->
                        return@use ois.readObject() as Session
                    }
                } catch (e: Exception) {
                    _pref.edit().remove(_sessionKey).commit()
                    incompleteSession()
                }
            } else {
                incompleteSession()
            }
        }

        set(session) {
            val prefEdit = _pref.edit()
            // 세션 토큰 저장
            when(session) {
                is Token -> {
                    prefEdit.putString(_tokenAuthKey, session.refreshToken)
                    prefEdit.putString(_tokenAccessKey, session.egToken)
                }
                Session.Empty -> {
                    prefEdit.remove(_tokenAuthKey)
                    prefEdit.remove(_tokenAccessKey)
                }
            }

            // 세션 객체 저장
            ByteArrayOutputStream().use { bo ->
                ObjectOutputStream(bo).use { oo -> oo.writeObject(session) }
                val sessionString = Base64.encodeToString(bo.toByteArray(), 0)
                prefEdit.putString(_sessionKey, sessionString)
                return@use
            }

            // preference 트랜잭션 완료
            prefEdit.commit()
        }

    override fun revoke() {
        _pref.edit().apply {
            remove(_sessionKey)
            remove(_tokenAuthKey)
            remove(_tokenAccessKey)
        }.commit()
    }
}