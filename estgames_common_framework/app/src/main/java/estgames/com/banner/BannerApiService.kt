package estgames.com.banner

import android.content.Context
import android.util.Log
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import org.json.JSONObject

/**
 * Created by mp on 2018. 1. 25..
 */
class BannerApiService {
    val bannerApiUrl: String = "https://8726wj937l.execute-api.ap-northeast-2.amazonaws.com/live?region=catcafe.kr.ls&lang=ko&placement=LANDING"
    var result: String = ""

    constructor(context: Context) {
        val myJson = JSONObject()
        val requestBody = myJson.toString()

        val bannerRequest = object : StringRequest(Method.GET, bannerApiUrl, Response.Listener { response ->
            result = response
        }, Response.ErrorListener { error ->
            Log.d("ERROR", "서버 Response 가져오기 실패: $error")
        }) {
            override fun getBodyContentType(): String {
                return "application/json; charset=utf-8"
            }

            override fun getBody(): ByteArray {
                return requestBody.toByteArray()
            }
        }

        Volley.newRequestQueue(context).add(bannerRequest)
    }
}