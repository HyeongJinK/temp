package com.estgames.estgames_framework.common

import android.content.Context
import com.estgames.estgames_framework.core.Api
import com.estgames.estgames_framework.core.Configuration
import com.estgames.estgames_framework.core.PlatformContext
import org.json.JSONObject

class GameService(context: Context, configuration: Configuration) {
    constructor(context: Context): this(context, (context.applicationContext as PlatformContext).configuration)

    private val ctx: PlatformContext = context.applicationContext as PlatformContext
    private val configuration: Configuration = configuration

    fun retrieveGameUser(egId: String): String {
        val result = Api.GameUser(configuration.region, egId).json();
        return result.getString("character")
    }

    private fun Api.json(): JSONObject {
        var res = this.invoke()
        return JSONObject(String(res.content, Charsets.UTF_8))
    }
}