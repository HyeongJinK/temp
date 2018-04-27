package com.estgames.estgames_framework.core


sealed class Either<out L, out R> {
    abstract fun <T> leftTo(f: (L) -> T): Either<out T, R>
    abstract fun <T> rightTo(f: (R) -> T): Either<L, out T>

    abstract fun left(f: (L) -> Unit): Either<L, R>
    abstract fun right(f: (R) -> Unit): Either<L, R>

    abstract val isRight: Boolean
    abstract val isLeft: Boolean
}

class Left<out L>(val value: L): Either<L, Nothing>() {
    override val isRight: Boolean = false
    override val isLeft: Boolean = true

    override fun <T> leftTo(f: (L) -> T): Either<out T, Nothing> {
        return Left(f(value))
    }

    override fun <T> rightTo(f: (Nothing) -> T): Either<L, out T> {
        return Left(value)
    }

    override fun left(f: (L) -> Unit): Either<L, Nothing> {
        f(value)
        return Left(value)
    }

    override fun right(f: (Nothing) -> Unit): Either<L, Nothing> {
        return Left(value)
    }
}

class Right<out R>(val value: R): Either<Nothing, R>() {
    override val isRight: Boolean = true
    override val isLeft: Boolean = false

    override fun <T> leftTo(f: (Nothing) -> T): Either<out T, R> {
        return Right(value)
    }

    override fun <T> rightTo(f: (R) -> T): Either<Nothing, out T> {
        return Right(f(value))
    }

    override fun left(f: (Nothing) -> Unit): Either<Nothing, R> {
        return Right(value)
    }

    override fun right(f: (R) -> Unit): Either<Nothing, R> {
        f(value)
        return Right(value)
    }
}

