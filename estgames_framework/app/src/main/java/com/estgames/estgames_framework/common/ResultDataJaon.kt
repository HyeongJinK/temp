package com.estgames.estgames_framework.common

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import org.json.JSONArray
import org.json.JSONObject
import java.net.URL
import java.text.SimpleDateFormat
import java.util.*
import javax.net.ssl.HttpsURLConnection

/**
 * Created by mp on 2018. 5. 1..
 */


class ResultDataJson {
    var nation: String = ""
    var language: String = ""
    var events: ArrayList<Event> = ArrayList<Event> ()
    //var process: String = ""
    var url: UrlData

    constructor(jsonData: String) {
        val json: JSONObject = JSONObject(jsonData).getJSONObject("mr.global.ls")

        nation = json.optString("nation")
        language = json.optString("language")
        //placement = json.optString("placement")
        url = UrlData(json.getJSONObject("url"))
        var temp: JSONArray = json.getJSONArray("event")

        for (i in 1 .. temp.length()) {
            events.add(Event(temp.getJSONObject(i - 1)))
        }
    }
}

class Event {
    var begin: Date?
    var end: Date?
    var banner : BannerData?

    constructor(jsonData: JSONObject) {
        var dt: SimpleDateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

        if (jsonData.optString("begin") != "null") {
            begin = dt.parse(jsonData.optString("begin"))
        } else {
            begin = null
        }

        if (jsonData.optString("end") != "null") {
            end = dt.parse(jsonData.optString("end"))
        } else {
            end = null
        }


        var todayDate = Date()
        if (begin != null && begin!!.after(todayDate)) {
            banner = null
        } else if (end != null && end!!.before(todayDate)) {
            banner = null
        } else {
            banner = BannerData(jsonData.getJSONObject("banner"))
        }
    }
}

class BannerData {
    var name: String = ""
    var resource: String = ""
    var writer: String = ""
    var action: ActionData
    var image : Bitmap

    constructor(jsonData: JSONObject) {
        name = jsonData.optString("name")
        resource = jsonData.optString("resource")
        writer = jsonData.optString("writer")
        action = ActionData(jsonData.getJSONObject("action"))

        val url = URL(resource)
        val conn = url.openConnection() as HttpsURLConnection
        conn.doInput = true
        conn.connect()
        val istream = conn.inputStream
        image = BitmapFactory.decodeStream(istream)
    }
}

class ActionData {
    var type: String = ""
    var url: String = ""
    var button: String = ""

    constructor(jsonData: JSONObject) {
        type = jsonData.optString("type")
        if (type == "NONE") {
            url = ""
            button = ""
        } else {
            url = jsonData.optString("url")
            button = jsonData.optString("button")
        }

    }
}

class UrlData {
    var system_contract: String = ""
    var contract_service: String = ""
    var contract_private: String = ""
    var notice: String = ""
    var cscenter:String = ""
    var apiParent:String = ""
    var characterInfo:String = ""

    constructor(jsonData: JSONObject) {
        system_contract = jsonData.optString("system_contract")
        notice = jsonData.optString("notice")
        cscenter = jsonData.optString("cscenter")
        apiParent = jsonData.optString("api_parent")
        characterInfo = jsonData.optString("character_info")

        var useContract = jsonData.getJSONObject("use_contract")

        contract_service = useContract.optString("service")
        contract_private = useContract.optString("private")
    }
}