package com.estgames.estgames_framework.core

import org.json.JSONObject


sealed class Api(val url: String, val method: Method, val data: Map<String, Any>) {
    companion object {
        private const val MP_PROCESS_DESCRIPTION_API_HOST = "https://m-linker.estgames.co.kr/sd_v_1_live"
        private const val MP_GAME_API_HOST = "https://mp-pub.estgames.co.kr"
        private const val MP_BRIDGE_API_HOST = "https://api-account.estgames.co.kr"
        private const val MP_BRIDGE_API_VERSION = "v2"
    }

    fun invoke(): HttpResponse {
        return request(url, method, data)
    }

    class ProcessDescribe(region: String, lang: String):
            Api("$MP_PROCESS_DESCRIPTION_API_HOST", Method.GET,
                    hashMapOf("region" to region, "lang" to lang)
            )

    class Token(clientId: String, secret: String, region:String, device:String, principal: String):
            Api("$MP_BRIDGE_API_HOST/$MP_BRIDGE_API_VERSION/account/token", Method.POST,
                    hashMapOf(
                            "client_id" to clientId,
                            "secret" to secret,
                            "region" to region,
                            "device" to device,
                            "principal" to principal,
                            "approval_type" to "principal")
            )

    class Refresh(
            clientId: String, secret:String, region:String,
            device:String, refreshToken:String, egToken:String):
            Api("$MP_BRIDGE_API_HOST/$MP_BRIDGE_API_VERSION/account/token", Method.POST,
                    hashMapOf(
                            "client_id" to clientId,
                            "secret" to secret,
                            "region" to region,
                            "device" to device,
                            "approval_type" to "refresh_token",
                            "refresh_token" to refreshToken,
                            "eg_token" to egToken))

    class Me(egToken: String) : Api(
            "$MP_BRIDGE_API_HOST/$MP_BRIDGE_API_VERSION/account/me", Method.GET,
            hashMapOf("eg_token" to egToken)
    )

    class Synchronize(egToken: String, principal: String, data: Map<String, Any> = mapOf(), force: Boolean = false): Api(
            "$MP_BRIDGE_API_HOST/$MP_BRIDGE_API_VERSION/account/synchronize", Method.POST,
            hashMapOf(
                    "eg_token" to egToken,
                    "principal" to principal,
                    "data" to JSONObject(data).toString(),
                    "force" to force)
    )

    class Expire(egToken: String): Api(
            "$MP_BRIDGE_API_HOST/$MP_BRIDGE_API_VERSION/account/signout", Method.POST,
            hashMapOf("eg_token" to egToken)
    )

    class Abandon(egToken: String, clientId: String, secret: String, region: String): Api(
            "$MP_BRIDGE_API_HOST/$MP_BRIDGE_API_VERSION/account/abandon", Method.POST,
            hashMapOf(
                    "eg_token" to egToken,
                    "client_id" to clientId,
                    "secret" to secret,
                    "region" to region
            )
    )

    class GameUser(region: String, egId: String, lang: String): Api(
            "$MP_GAME_API_HOST/live/game/$region", Method.GET, hashMapOf("eg_id" to egId, "lang" to lang)
    )

    class GameServiceStatus(region: String, lang: String): Api (
            "$MP_GAME_API_HOST/live/game-open-status", Method.GET, hashMapOf("region" to region, "lang" to lang)
    )
}
