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


data class ServiceStatus(
        val isServiceOn: Boolean,
        val remainSeconds: Int,
        val noticeUrl: String
) {
    val remainMinutes: Int get() = if (remainSeconds > 0) {
        remainSeconds / 60
    } else {
        0
    }
}

class GameAgent(context: Context, configuration: Configuration) {
    companion object {
        private const val TAG = "GameAgent"
    }

    constructor(context: Context): this(context, (context.applicationContext as PlatformContext).configuration)

    private val ctx: PlatformContext = context.applicationContext as PlatformContext
    private val configuration: Configuration = configuration
    private val preferences: ClientPreferences = ClientPreferences(context)

    interface StatusReceiver {
        fun onReceived(status: ServiceStatus)
        fun onError(fail: Fail)
    }

    fun retrieveGameUser(egId: String, lang: String): String {
        try {
            val result = Api.GameUser(configuration.region, egId, lang).json()
            return result.getString("character")
        } catch (e: InternalException) {
            throw Fail.API_CHARACTER_INFO.with(e.message, e.cause)
        }
    }

    fun retrieveStatus(l: StatusReceiver) {
        Requester(
            executor = {retrieveStatusAsJson()},
            listener = { result ->
                result.right {
                    l.onReceived(ServiceStatus(
                            it.getString("status").equals("on"),
                            it.getInt("time"),
                            it.getString("url")
                    ))
                }.left { e ->
                    Log.e(TAG, e.message, e)
                    when (e) {
                        is InternalException -> l.onError(Fail.API_BAD_REQUEST)
                        is EGException -> l.onError(e.code)
                        else -> l.onError(Fail.API_REQUEST_FAIL)
                    }
                }
            }
        ).execute();
    }

    fun retrieveStatus(): ServiceStatus {
        try {
            return Executors.newSingleThreadExecutor().use { exe ->
                val result = exe.submit(Callable {
                    retrieveStatusAsJson().run {
                        ServiceStatus(
                                getString("status").equals("on"),
                                getInt("time"),
                                getString("url")
                        )
                    }
                })
                return@use result.get()
            }
        } catch (e: InternalException) {
            throw Fail.API_BAD_REQUEST.with(e.message, e)
        }
    }

    private fun retrieveStatusAsJson(): JSONObject {
        return Api.GameServiceStatus(configuration.region, preferences.locale.language).json()
    }

    private fun Api.json(): JSONObject {
        val r = this.invoke()
        try {
            var msg = JSONObject(String(r.content, Charsets.UTF_8))
            if (r.status == 200) {
                return msg
            } else {
                throw InternalException(msg.getInt("code"), msg.getString("message"))
            }
        } catch (e: JSONException) {
            throw InternalException(r.status, r.message, e);
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

    private class InternalException @JvmOverloads constructor(
            val code: Int,
            override val message: String,
            override val cause: Throwable? = null
    ): Exception(message, cause)
}