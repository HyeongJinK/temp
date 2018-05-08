package com.estgames.estgames_framework.core

import android.content.Context
import android.content.pm.PackageManager
import android.provider.Settings
import android.telephony.TelephonyManager
import java.io.ByteArrayInputStream
import java.security.MessageDigest
import java.security.cert.CertificateFactory
import java.util.*
import java.security.cert.X509Certificate

object AndroidUtils {
    private const val GENERAL_ID = "9774d56d682e549c"
    private const val PREFS_FILE = "eg_client_prefs.xml"
    private const val PREFS_FILE_DEVICE = "device_id"

    @JvmStatic
    fun obtainDeviceId(context: Context): UUID {
        val prefs = context.getSharedPreferences(PREFS_FILE, 0)
        val deviceId = prefs.getString(PREFS_FILE_DEVICE, null)

        if (deviceId != null) {
            return UUID.fromString(deviceId)
        }

        val androidId = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
        val uuid = if (androidId != GENERAL_ID) {
            UUID.nameUUIDFromBytes(androidId.toByteArray(Charsets.UTF_8))
        } else {
            val tm = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            if (tm.deviceId != null) {
                UUID.nameUUIDFromBytes(tm.deviceId.toByteArray(Charsets.UTF_8))
            } else {
                UUID.randomUUID()
            }
        }

        prefs.edit().putString(PREFS_FILE_DEVICE, uuid.toString()).commit()
        return uuid
    }
    @JvmStatic
    fun obtainFingerPrint(context: Context): String {
        val pack = context.packageManager.getPackageInfo(
                context.packageName, PackageManager.GET_SIGNATURES
        )
        val cf = CertificateFactory.getInstance("X509")

        return pack.signatures.map { sig ->
            val x509 = cf.generateCertificate(ByteArrayInputStream(sig.toByteArray())) as X509Certificate
            val pk = MessageDigest.getInstance("SHA1").digest(x509.encoded)
            return@map pk.map { String.format("%02x", it) }.reduce { a, b -> "$a:$b"}.toUpperCase()
        }[0]
    }
}