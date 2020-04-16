package com.estgames.estgames_framework.common

import android.app.Activity
import android.content.Context
import java.util.*

class ClientPreferences(context: Context) {
    companion object {
        private const val EG_CLIENT_PREFERENCES = "com.estgames.client.preferences"
        private const val LOCALE = "eg.locale"
        private const val TERM = "eg.terms.confirmed"
    }

    private val repo = context.getSharedPreferences(EG_CLIENT_PREFERENCES, Activity.MODE_PRIVATE)

    var locale: Locale
        get() {
            val l = repo.getString(LOCALE, null)
            return if (l != null) {
                    Locale(l)
                } else {
                    Locale.getDefault()
                }
        }

        set(lo) {
            repo.edit().putString(LOCALE, lo.toString()).commit()
        }

    var termsAgreement: Boolean
        get() {
            return repo.getBoolean(TERM, false)
        }
        set(value) {
            repo.edit().putBoolean(TERM, value).commit()
        }

    fun clear() {
        repo.edit().clear().commit()
    }
}
