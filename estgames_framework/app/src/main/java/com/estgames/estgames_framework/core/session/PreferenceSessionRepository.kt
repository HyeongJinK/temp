package com.estgames.estgames_framework.core.session

import android.content.Context

import android.util.Base64
import com.estgames.estgames_framework.core.Session
import java.io.*

class PreferenceSessionRepository(context:Context): SessionRepository {
    companion object {
        private const val SESSION_FILE = "eg_platform_session.xml"
        private const val SESSION_OBJECT = "session"
    }

    private val _pref = context.getSharedPreferences(SESSION_FILE, Context.MODE_PRIVATE)

    override val hasSession: Boolean
        get() {
            return _pref.getString(SESSION_OBJECT, null) != null
        }

    override var session: Session
        get() {
            val sessionString = _pref.getString(SESSION_OBJECT, null) ?: return Session.Empty
            val ois = ObjectInputStream(ByteArrayInputStream(Base64.decode(sessionString, 0)))
            ois.use { ois ->
                return ois.readObject() as Session
            }
        }

        set(session) {
            ByteArrayOutputStream().use { bo ->
                ObjectOutputStream(bo).use { oo -> oo.writeObject(session) }
                val sessionString = Base64.encodeToString(bo.toByteArray(), 0)
                _pref.edit().putString(SESSION_OBJECT, sessionString).commit()
                return
            }
        }

    override fun revoke() {
        _pref.edit().remove(SESSION_OBJECT).commit()
    }
}