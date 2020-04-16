package com.estgames.estgames_framework.banner

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Base64
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.ObjectInputStream
import java.io.ObjectOutputStream
import java.io.Serializable
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.HashMap

class BannerCacheRepository(context: Context) {
    companion object {
        private const val BANNER_CACHE = "com.estgames.banner.cache"
        private const val BANNER_CONTAINER = "banner.map"

        private val DATE_FORMAT = SimpleDateFormat("yyyy-MM-dd")
    }

    private data class Banner(val name: String, var hideOn: Date? = null): Serializable

    private var preference = context.getSharedPreferences(BANNER_CACHE, Activity.MODE_PRIVATE)
    private var banners = hashMapOf<String, Banner>()

    init {
        load()
    }

    fun set(key: String) {
    }

    fun get(key: String) {
    }

    fun delete(key: String) {
    }

    fun clear() {
        preference.edit().remove(BANNER_CONTAINER).commit()
    }

    fun isHideOnToday(key: String): Boolean {
        return if (key in banners) {
            if (banners.get(key)!!.hideOn != null) {
                var hDay = DATE_FORMAT.format(banners.get(key)!!.hideOn)
                var today = DATE_FORMAT.format(Date(System.currentTimeMillis()))
                today.equals(hDay)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun setHideOnToday(key: String, check: Boolean) {
        val banner = banners.get(key) ?: Banner(key);
        banner.hideOn = Date(System.currentTimeMillis())

        if (check) {
            banners.put(key, banner)
        } else {
            banners.remove(key)
        }
    }

    fun dispose() {
        write()
    }

    private fun load() {
        val bannerData = preference.getString(BANNER_CONTAINER, null)
        try {
            if (bannerData != null) {
                banners = ObjectInputStream(ByteArrayInputStream(Base64.decode(bannerData, 0))).use { oi ->
                    oi.readObject() as HashMap<String, Banner>
                }
            }
        } catch (e: Exception) {
            clear()
        }
    }

    private fun write() {
        ByteArrayOutputStream().use { bo ->
            ObjectOutputStream(bo).use { oo -> oo.writeObject(banners) }

            var bannerData = Base64.encodeToString(bo.toByteArray(), 0)
            preference.edit().putString(BANNER_CONTAINER, bannerData).commit()
            return@use
        }
    }
}
