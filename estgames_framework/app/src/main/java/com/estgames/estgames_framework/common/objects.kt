package com.estgames.estgames_framework.common

import org.json.JSONArray
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*

object ProcessDescriptionParser {
    private val DATE_FORMAT = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ")

    @JvmStatic fun parse(stringData: String): ProcessDescription {
        var today = Calendar.getInstance(TimeZone.getTimeZone("UTC")).time
        val data = JSONObject(stringData)
        val nation = data.getString("nation")
        val language = data.getString("language")
        val process = data.getJSONArray("process")
        val banners:JSONArray = data.getJSONArray("banner")
        val src = data.getJSONObject("url")

        return ProcessDescription(
                nation, language,
                Array(process.length()) { i -> process[i].toString() },
                Array(banners.length()) { i ->
                    val obj = banners[i] as JSONObject
                    val action = obj.getJSONObject("banner").getJSONObject("action")

                    return@Array Banner(
                            obj.asDatetime("begin"),
                            obj.asDatetime("end"),
                            obj.getJSONObject("banner").getString("name"),
                            obj.getJSONObject("banner").getJSONObject("content").getString("resource"),
                            obj.getJSONObject("banner").getJSONObject("content").getString("type"),
                            when(action.getString("type")) {
                                "WEB_VIEW" -> Action.WebView(action.getString("url"), action.getString("button"))
                                "WEB_BROWSER" -> Action.WebBrowser(action.getString("url"), action.getString("button"))
                                else -> Action.None
                            }
                    )
                } .filter { e ->
                    (e.begin == null) || (e.begin!!.before(today) && e.end!!.after(today))
                },
                UrlDescription(
                        src.getString("notice"),
                        src.getString("event"),
                        src.getString("cscenter"),
                        src.getString("system_contract"),
                        src.getJSONObject("use_contract").getString("service"),
                        src.getJSONObject("use_contract").getString("private")
                )
        )
    }

    private fun JSONObject.asDatetime(key: String): Date? {
        return if (this.isNull(key))
            null
        else
            DATE_FORMAT.parse(this.getString(key))
    }
}

data class ProcessDescription(
        val nation: String,
        val language: String,
        val process: Array<String>,
        val banners: List<Banner>,
        val url: UrlDescription
)

data class Banner(
        val begin: Date?,
        val end: Date?,
        val name: String,
        val resource: String,
        val contentType: String,
        val action: Action
)

sealed class Action {
    data class WebView(val url: String, val button: String): Action()
    data class WebBrowser(val url: String, val button: String): Action()
    object None: Action()
}

data class UrlDescription(
        val notice: String,
        val event: String,
        val cs: String,
        val authority: String,
        val contractService: String,
        val contractPrivate: String
)
