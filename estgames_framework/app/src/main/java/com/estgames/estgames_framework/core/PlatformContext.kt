package com.estgames.estgames_framework.core

import com.estgames.estgames_framework.core.session.SessionRepository

interface PlatformContext {
    val configuration: Configuration
    val deviceId: String

    val sessionRepository: SessionRepository
}
