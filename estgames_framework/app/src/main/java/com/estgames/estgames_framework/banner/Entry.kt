package com.estgames.estgames_framework.banner

import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*

/**
 * Created by mp on 2018. 1. 23..
 */
class Entry  {
    var begin: Date?
    var end: Date?
    var banner : Banner

    constructor(jsonData: JSONObject) {
        var dt:SimpleDateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

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

        banner = Banner(jsonData.getJSONObject("banner"))
    }
}