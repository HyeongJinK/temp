package estgames.com.banner

import org.json.JSONObject

/**
 * Created by mp on 2018. 1. 23..
 */
class Banner {
    var name: String = ""
    var resource: String = ""
    var writer: String = ""
    var action: Action

    constructor(jsonData: JSONObject) {
        name = jsonData.optString("name")
        resource = jsonData.optString("resource")
        writer = jsonData.optString("writer")
        action = Action(jsonData.getJSONObject("action"))
    }
}