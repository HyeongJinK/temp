package com.estgames.estgames_framework.common

import android.content.Context
import android.os.AsyncTask
import android.util.Log
import com.estgames.estgames_framework.core.*
import org.json.JSONException
import org.json.JSONObject
import java.util.concurrent.Callable
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors


class GameAgent(context: Context, configuration: Configuration) {
    companion object {
        private const val TAG = "GameAgent"
    }

    constructor(context: Context): this(context, (context.applicationContext as PlatformContext).configuration)

    private val ctx: PlatformContext = context.applicationContext as PlatformContext
    private val configuration: Configuration = configuration

    interface StatusReceiver {
        fun onReceived(isServiceOn: Boolean)
        fun onError(fail: Fail)
    }

    fun retrieveGameUser(egId: String): String {
        val result = Api.GameUser(configuration.region, egId).json()
        return result.getString("character")
    }

    fun retrieveStatus(l: StatusReceiver) {
        Requester(
            executor = {retrieveStatusAsJson()},
            listener = { result ->
                result.right {
                    l.onReceived(it.getString("status").equals("on"))
                }.left { e ->
                    Log.e(TAG, e.message, e)
                    when (e) {
                        is EGException -> l.onError(e.code)
                        else -> l.onError(Fail.API_REQUEST_FAIL)
                    }
                }
            }
        ).execute();
    }

    fun retrieveStatus(): Boolean {
        return Executors.newSingleThreadExecutor().use { exe ->
            val result = exe.submit(Callable {
                retrieveStatusAsJson().getString("status").equals("on")
            })
            return@use result.get()
        }
    }

    private fun retrieveStatusAsJson(): JSONObject {
        return Api.GameServiceStatus(configuration.region).json()
    }

    private fun Api.json(): JSONObject {
        val r = this.invoke()
        if (r.status == 200) {
            return JSONObject(String(r.content, Charsets.UTF_8))
        }

        try {
            var msg = JSONObject(String(r.content, Charsets.UTF_8))
            throw Fail.resolve(msg.getString("code"), msg.getString("message"))
        } catch (e: JSONException) {
            throw Fail.API_REQUEST_FAIL.with("API Request Fail. - http response status : ${r.status}, message: ${r.message}")
        }
    }

    private inline fun <R> ExecutorService.use(code: (ExecutorService) -> R): R {
        try {
            return code(this)
        } finally {
            this.shutdown();
        }
    }

    private class Requester(
            val executor: () -> JSONObject,
            val listener: (Either<Throwable, JSONObject>) -> Unit
    ): AsyncTask<Void, Void, Either<Throwable, JSONObject>>() {

        override fun doInBackground(vararg p0: Void?): Either<Throwable, JSONObject> {
            try {
                return Right(executor())
            } catch (t: Throwable) {
                return Left(t)
            }
        }

        override fun onPostExecute(result: Either<Throwable, JSONObject>) {
            listener(result)
        }
    }
}