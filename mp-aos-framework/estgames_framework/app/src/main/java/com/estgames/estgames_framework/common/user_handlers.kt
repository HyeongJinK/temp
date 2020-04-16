package com.estgames.estgames_framework.common

import com.estgames.estgames_framework.core.Fail
import com.estgames.estgames_framework.core.Result


interface LoginResultHandler {
    fun onComplete(result: Result.Login)
    fun onFail(code: Fail)
    fun onCancel()
}

interface LoginComplete {
    fun onComplete()
}

interface LoginFailure {
    fun onFail(code:Fail)
}

interface LoginCanceled {
    fun onCanceled()
}
