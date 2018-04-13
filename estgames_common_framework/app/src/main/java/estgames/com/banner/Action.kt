package estgames.com.banner

import org.json.JSONObject

/**
 * Created by mp on 2018. 1. 23..
 */
class Action {
    var type: String = ""
    var url: String = ""
    var button: String = ""

    constructor(jsonData: JSONObject) {
        type = jsonData.optString("type")
        url = jsonData.optString("url")
        button = jsonData.optString("button")
    }
}