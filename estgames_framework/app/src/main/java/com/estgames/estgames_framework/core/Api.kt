package com.estgames.estgames_framework.core

import org.json.JSONObject


sealed class Api(val url: String, val method: Method, val data: Map<String, Any>) {
    companion object {
        private const val MP_API_HOST = "https://api-account-stage.estgames.co.kr"
        private const val MP_API_VERSION = "v2"
    }

    fun invoke(): HttpResponse {
        return request(url, method, data)
    }

    class Token(clientId: String, secret: String, region:String, device:String, principal: String):
            Api("$MP_API_HOST/$MP_API_VERSION/account/token", Method.POST,
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
            Api("$MP_API_HOST/$MP_API_VERSION/account/token", Method.POST,
                    hashMapOf(
                            "client_id" to clientId,
                            "secret" to secret,
                            "region" to region,
                            "device" to device,
                            "approval_type" to "refresh_token",
                            "refresh_token" to refreshToken,
                            "eg_token" to egToken))

    class Me(egToken: String) : Api(
            "$MP_API_HOST/$MP_API_VERSION/account/me", Method.GET,
            hashMapOf("eg_token" to egToken)
    )

    class Synchronize(egToken: String, principal: String, data: Map<String, Any> = mapOf(), force: Boolean = false): Api(
            "$MP_API_HOST/$MP_API_VERSION/account/synchronize", Method.POST,
            hashMapOf(
                    "eg_token" to egToken,
                    "principal" to principal,
                    "data" to JSONObject(data).toString(),
                    "force" to force)
    )

    class Expire(egToken: String): Api(
            "$MP_API_HOST/$MP_API_VERSION/account/signout", Method.POST,
            hashMapOf("eg_token" to egToken)
    )

    class Abandon(egToken: String, client_id: String, secret: String, region: String): Api(
            "$MP_API_HOST/$MP_API_VERSION/account/abandon", Method.POST,
            hashMapOf(
                    "eg_token" to egToken,
                    "client_id" to client_id,
                    "secret" to secret,
                    "region" to region
            )
    )
}
