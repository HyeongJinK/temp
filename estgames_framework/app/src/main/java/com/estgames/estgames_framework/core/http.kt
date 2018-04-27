@file:JvmName("HttpUtils")

package com.estgames.estgames_framework.core

import java.io.*
import java.net.HttpURLConnection
import java.net.URL
import java.security.cert.X509Certificate
import javax.net.ssl.HttpsURLConnection
import javax.net.ssl.SSLContext
import javax.net.ssl.X509TrustManager


fun request(url: String, method: Method): HttpResponse {
    return request(url, method, mapOf())
}

fun request(url: String, method: Method, data: Map<String, Any>): HttpResponse {
    return request(url, method, data, mapOf())
}

/**
 * Http 요청을 호출하는 함수
 */
fun request(url: String,
            method: Method,
            data: Map<String, Any>,
            headers: Map<String, String>): HttpResponse {

    return HttpRequest(method, url, headers, data).request()
}


/**
 * Http 요청 메소드 열거형
 */
enum class Method(val containsBody: Boolean = false) {
    GET(false),
    POST(true),
    PUT(true),
    DELETE(false),
    HEAD(false),
    OPTION(false),
}

/**
 * Http Request 객체
 */
class HttpRequest(val method: Method, url: String, headers: Map<String, String>, data: Map<String, Any>) {
    /** data 값들을 a=1&b=2&c=3 형태의 query string으로 변환 */
    private val _query = data.entries
            .map { entry -> "${entry.key}=${entry.value}" }
            .fold ("", { result, v -> "$result&$v"})

    private val _url = if (!method.containsBody) {
        if (url.indexOf('?') > 0) "$url&$_query" else "$url?$_query"
    } else {
        url
    }

    private val _connection: HttpURLConnection by lazy {
        val conn = URL(_url).openConnection() as HttpURLConnection
        if (_url.startsWith("https:")) {
            val ctx = SSLContext.getInstance("TLS")
            ctx.init(null, arrayOf(X509TrustManagerImpl()), null)
            (conn as HttpsURLConnection).sslSocketFactory = ctx.socketFactory
        }

        conn.requestMethod = method.name
        conn.doOutput = method.containsBody
        conn
    }

    private val _headers by lazy {
        val contentType =
                if(method.containsBody)
                    "application/x-www-form-urlencoded;charset=utf-8"
                else
                    "text/plain"

        var hMap = hashMapOf(
                "Accept" to "*",
                "Accept-Charset" to "utf-8",
                "Cache-Control" to "no-cache",
                "Content-type" to contentType)

        headers.entries.forEach { entry -> hMap.put(entry.key, entry.value)}
        hMap.toMap()
    }

    fun request(): HttpResponse {
        val conn = _connection
        try {
            _headers.entries.forEach { entry -> conn.setRequestProperty(entry.key, entry.value) }

            if (method.containsBody) {
                val os = DataOutputStream(conn.outputStream)
                os.write(_query.toByteArray(Charsets.UTF_8))
                os.flush()
                os.close()
            } else {
                conn.connect()
                conn.instanceFollowRedirects = true
            }

            return when(conn.responseCode) {
                200 -> HttpResponse(conn.inputStream, conn.responseCode, conn.responseMessage)
                else -> HttpResponse(conn.errorStream, conn.responseCode, conn.responseMessage)
            }

        } finally {
            conn.disconnect()
        }
    }
}

class HttpResponse constructor(stream: InputStream, val status: Int, val message: String) {
    val content = getBytes(stream)
    val inputStream: InputStream
            get() = ByteArrayInputStream(content)
    val reader: Reader
            get() = InputStreamReader(ByteArrayInputStream(content), "utf-8")

    private fun getBytes(stream: InputStream): ByteArray {
        val out = ByteArrayOutputStream()
        StreamIterator(stream).iterator().forEach { data -> out.write(data) }
        return out.toByteArray()
    }

    private class StreamIterator(stream: InputStream): Iterator<ByteArray> {
        val stream = BufferedInputStream(stream)
        var data = ByteArray(2048)
        var bound = 0

        override operator fun hasNext(): Boolean {
            bound = stream.read(data)
            return bound != -1
        }

        override operator fun next(): ByteArray {
            return data.copyOfRange(0, bound)
        }

        operator fun iterator(): StreamIterator {
            return this
        }
    }
}

private class X509TrustManagerImpl(): X509TrustManager {
    override fun checkClientTrusted(p0: Array<out X509Certificate>?, p1: String?) {}
    override fun checkServerTrusted(p0: Array<out X509Certificate>?, p1: String?) {}
    override fun getAcceptedIssuers(): Array<X509Certificate> { return arrayOf() }
}