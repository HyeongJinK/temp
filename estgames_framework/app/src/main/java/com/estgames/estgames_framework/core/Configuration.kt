package com.estgames.estgames_framework.core

import android.content.Context

import java.util.*
import org.json.JSONObject


class Configuration private constructor(context:Context, config:JSONObject) {
    companion object {
        private const val RESOURCE_IDENTIFIER = "egconfiguration"

        fun getResourceIdentifier(context: Context): Int {
            return context.resources.getIdentifier(RESOURCE_IDENTIFIER, "raw", context.packageName)
        }

        private fun parseConfig(context: Context, resourceId:Int): JSONObject {
            var scan = Scanner(context.resources.openRawResource(resourceId))
            var buf = StringBuilder()
            scan.forEach { buf.append(it) }
            scan.close()

            return JSONObject(buf.toString())
        }
    }

    constructor(context: Context): this(context, getResourceIdentifier(context))

    constructor(context: Context, resourceId: Int): this(context, parseConfig(context, resourceId))


    private val context = context
    private val config = config

    val clientId by lazy {
        config.getJSONObject("Client").getString("ClientId")
    }

    val secret by lazy {
        config.getJSONObject("Client").getString("Secret")
    }

    val region by lazy {
        config.getJSONObject("Client").getString("Region")
    }
}