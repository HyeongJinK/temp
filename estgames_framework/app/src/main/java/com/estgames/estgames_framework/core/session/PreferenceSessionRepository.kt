package com.estgames.estgames_framework.core.session

import android.content.Context

import android.util.Base64
import com.estgames.estgames_framework.core.Configuration
import com.estgames.estgames_framework.core.Session
import java.io.*

class PreferenceSessionRepository(context:Context, private val configuration: Configuration): SessionRepository {
    companion object {
        private const val SESSION_FILE = "eg_platform_session.xml"
        private const val SESSION_OBJECT = "%s.session"
    }

    private val _pref = context.getSharedPreferences(SESSION_FILE, Context.MODE_PRIVATE)
    private val _sessionKey by lazy {
        String.format(SESSION_OBJECT, configuration.region)
    }

    override val hasSession: Boolean
        get() {
            return _pref.getString(_sessionKey, null) != null
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
                    revoke()
                    Session.Empty
                }
            } else {
                Session.Empty
            }
        }

        set(session) {
            ByteArrayOutputStream().use { bo ->
                ObjectOutputStream(bo).use { oo -> oo.writeObject(session) }
                val sessionString = Base64.encodeToString(bo.toByteArray(), 0)
                _pref.edit().putString(_sessionKey, sessionString).commit()
                return@use
            }
        }

    override fun revoke() {
        _pref.edit().remove(_sessionKey).commit()
    }
}