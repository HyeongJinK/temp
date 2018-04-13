package estgames.com.banner

import org.json.JSONArray
import org.json.JSONObject

/**
 * Created by mp on 2018. 1. 23..
 */
class BannerJson {
    var region: String = ""
    var lang: String = ""
    var placement: String = ""
    var entries: ArrayList<Entry> = ArrayList<Entry> ()
    var key: String = ""

    constructor(jsonData: String) {
        val json: JSONObject = JSONObject(jsonData)

        region = json.optString("region")
        lang = json.optString("lang")
        placement = json.optString("placement")
        key = json.optString("key")
        var temp: JSONArray = json.getJSONArray("entries")

        for (i in 1 .. temp.length()) {
            entries.add(Entry(temp.getJSONObject(i - 1)))
        }
    }
}