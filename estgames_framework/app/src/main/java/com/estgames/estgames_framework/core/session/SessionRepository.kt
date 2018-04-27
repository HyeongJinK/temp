package com.estgames.estgames_framework.core.session

import com.estgames.estgames_framework.core.Session

interface SessionRepository {
    val hasSession: Boolean
    var session: Session

    fun revoke()
}