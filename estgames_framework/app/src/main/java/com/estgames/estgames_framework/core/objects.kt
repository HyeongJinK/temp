package com.estgames.estgames_framework.core

import java.io.Serializable
import java.util.*

interface Token {
    val egToken: String
    val refreshToken: String
}

interface Profile {
    val egId: String
    val principal: String
    val provider: String?
    val email: String?
    val userId: String
}

sealed class Session(): Serializable {
    data class Incomplete(
            override val egToken: String,
            override val refreshToken: String
    ) : Session(), Token

    data class Complete(
            override val egToken: String,
            override val refreshToken: String,
            override val egId: String,
            override val principal: String,
            override val provider: String? = null,
            override val email: String? = null,
            override val userId: String
    ) : Session(), Token, Profile

    object Empty: Session()
}

sealed class Result(): Serializable {
    data class Failure(val code: String, val message: String, val cause: Throwable? = null): Result()
    data class SyncComplete(
            val egId: String,
            val from: String,
            val to: String,
            val data: Map<String, Any>,
            val at: Date): Result()
    data class SyncFailure(val egId: String, val message: String): Result()
}
