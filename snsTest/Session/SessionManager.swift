//
//  SessionManager.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 18..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

class SessionManager {
    //세션생성
    let api: Api = Api()
    private func exchangePrincipal(identity: String) -> String {
        /**
         val result = Api.Principal(
         _platform.configuration.clientId,
         _platform.configuration.secret,
         identity).json()
         
         return result.getString("principal")
         */
        api.principal(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, identity: identity)
        
        return ""
    }
    func create(principal: String?) {
        let uid = UUID().uuidString
        let p = api.principal(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, identity: uid)
        let token = api.token(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, region: MpInfo.App.region, device: "\(uid)@ios", principal: p!)
        let egToken = token!["eg_token"] as! String
        let me = api.me(egToken: egToken)
        let profile = me!["profile"] as! [String:Any]
        
        MpInfo.Account.device = "\(uid)@ios"
        MpInfo.Account.egToken = token!["eg_token"] as! String
        MpInfo.Account.refreshToken = token!["refresh_token"] as! String
        MpInfo.Account.egId = me!["eg_id"] as! String
        MpInfo.Account.principal = me!["principal_of_client"] as! String
        MpInfo.Account.userId = me!["user_id"] as! String
        let _provider:String? = profile["provider"] as? String
        if _provider != nil {
            MpInfo.Account.provider = _provider!
        }
        let _email:String? = profile["email"] as? String
        if _email != nil {
            MpInfo.Account.email = _email!
        }
    }
    
    //세션 재시작
    func resume() {
        let token = api.refresh(clientId: MpInfo.App.clientId, secret: MpInfo.App.secret, region: MpInfo.App.region, device: MpInfo.Account.device, refreshToken: MpInfo.Account.refreshToken, egToken: MpInfo.Account.egToken)
        let egToken = token!["eg_token"] as! String
        let me = api.me(egToken: egToken)
        let profile = me!["profile"] as! [String:Any]

        MpInfo.Account.egToken = token!["eg_token"] as! String
        //MpInfo.Account.refreshToken = token!["refresh_token"] as! String
        MpInfo.Account.egId = me!["eg_id"] as! String
        MpInfo.Account.principal = me!["principal_of_client"] as! String
        MpInfo.Account.userId = me!["user_id"] as! String
        let _provider:String? = profile["provider"] as? String
        if _provider != nil {
            MpInfo.Account.provider = _provider!
        }
        let _email:String? = profile["email"] as? String
        if _email != nil {
            MpInfo.Account.email = _email!
        }
    }
    
    //계정 동기화
    func sync() {
    
    }
    
    //세션만료
    func expire() {
        api.expire(egToken: MpInfo.Account.egToken)
    }
    
    private func clearKeychain() {
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.eg_id")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.eg_token")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.refresh_token")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.principal")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.provider")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.email")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.device")
        KeychainWrapper.standard.removeObject(forKey: MpInfo.App.region+"_mp.user_id")
    }
    
    func signOut() {
        api.expire(egToken: MpInfo.Account.egToken)
        clearKeychain()
    }
}


/**
 class SessionManager private constructor(
 private val _platform: PlatformContext,
 private val _sessionRepo: SessionRepository
 ): MonitorContainer<Session> by _sessionRepo {
 
 constructor(context: Context): this(
 context.applicationContext as PlatformContext,
 (context.applicationContext as PlatformContext).sessionRepository
 )
 
 val await = Await()
 
 val isSessionOpen: Boolean get() { return _platform.sessionRepository.hasSession }
 
 val profile: Profile? get() {
 val s = _platform.sessionRepository.session
 return when(s) {
 is Profile -> s
 else -> null
 }
 }
 
 val token: Token? get() {
 val s = _platform.sessionRepository.session
 return when(s) {
 is Token -> s
 else -> null
 }
 }
 
 private val deviceIdentity:String
 get() {
 return ByteArrayOutputStream(16).use {bo ->
 DataOutputStream(bo).use {out ->
 out.write(_platform.deviceId.toByteArray(Charsets.UTF_8))
 out.writeLong(SystemClock.elapsedRealtime())
 }
 return@use bo.toByteArray()
 }.run {
 val r = MessageDigest.getInstance("SHA-256").digest(this)
 return@run Base64.encodeToString(r, Base64.DEFAULT)
 }
 }
 
 /**
 * 세션 오픈
 */
 @JvmOverloads
 fun open(executor:Executor = InstantThreadExecutor()): Task<String> {
 return Task(executor) {
 return@Task when (_sessionRepo.hasSession) {
 false -> {
 return@Task publishToken(exchangePrincipal(deviceIdentity))
 }
 else -> refreshToken()
 }
 }.thenApply {s ->
 _sessionRepo.session = s
 return@thenApply s.egToken
 }
 }
 
 /**
 * 세션 생성
 */
 @JvmOverloads
 fun create(principal: String? = null, executor: Executor= InstantThreadExecutor()): Task<String> {
 if (principal == null && _sessionRepo.hasSession) {
 throw Fail.ACCOUNT_SESSION_DUPLICATED.with("Guest session can not be duplicated. There is already a opened session.")
 }
 
 return Task(executor) {
 publishToken(principal?: exchangePrincipal(deviceIdentity))
 }.thenApply {s ->
 _sessionRepo.session = s
 return@thenApply s.egToken
 }
 }
 
 /**
 * 세션 재시작
 */
 @JvmOverloads
 fun resume(executor: Executor= InstantThreadExecutor()): Task<String> {
 return Task(executor) {
 refreshToken()
 }.thenApply {s ->
 _sessionRepo.session = s
 return@thenApply s.egToken
 }
 }
 
 /**
 * 사용자계정 데이터 동기화
 */
 @JvmOverloads
 fun sync(data: Map<String, Any>, principal: String? = null, force:Boolean = false,
 executor: Executor = InstantThreadExecutor()): Task<Result> {
 return Task(executor) {
 val session = _sessionRepo.session
 when (session) {
 is Session.Complete -> {
 return@Task synchronizeData(session.egToken, principal?: session.principal, data, force).apply {
 if (this is Result.SyncComplete) {
 _sessionRepo.session = session.extend(
 egId = egId, principal = to,
 provider = data["provider"]?.run { this.toString() },
 email = data["email"]?.run { this.toString() }
 )
 }
 }
 }
 else -> throw Fail.TOKEN_EMPTY.with("There is no complete session.")
 }
 }
 }
 
 private fun synchronizeData(token: String, principal: String, data: Map<String, Any>, force: Boolean = false):Result {
 val msg = Api.Synchronize(token, principal, data, force).json()
 return when(msg.getString("status").toUpperCase()) {
 "COMPLETE" -> {
 Result.SyncComplete(
 egId = msg.getString("eg_id"),
 from = msg.getString("from"),
 to = msg.getString("to"),
 data = msg.getJSONObject("data").toMap(),
 at = Date(System.currentTimeMillis())
 )
 }
 else -> {
 Result.SyncFailure(
 principal = principal,
 egId = msg.getString("duplicated"),
 message = msg.getString("message")
 )
 }
 }
 }
 
 /**
 * 세션 만료
 */
 @JvmOverloads
 fun expire(executor: Executor = InstantThreadExecutor()): Task<Unit> {
 return Task(executor) {
 expireToken()
 }
 }
 
 /**
 * Sign out. 세션정보를 삭제하고 로그아웃을 실행
 */
 @JvmOverloads
 fun signOut(executor: Executor = InstantThreadExecutor()): Task<Unit> = Task(executor) {
 expireToken()
 }.thenApply {
 _sessionRepo.disconnectProvider()
 _sessionRepo.revoke()
 }
 
 /**
 * 사용자 탈퇴.
 */
 @JvmOverloads
 fun revoke(executor: Executor = InstantThreadExecutor()): Task<Unit> {
 return Task(executor) {
 abandonAccount()
 }.thenApply {
 _sessionRepo.disconnectProvider()
 _sessionRepo.revoke()
 }
 }
 
 private fun exchangePrincipal(identity: String): String {
 val result = Api.Principal(
 _platform.configuration.clientId,
 _platform.configuration.secret,
 identity).json()
 
 return result.getString("principal")
 }
 
 private fun publishToken(principal: String): Session.Complete {
 val token = Api.Token(
 _platform.configuration.clientId,
 _platform.configuration.secret,
 _platform.configuration.region,
 _platform.deviceId,
 principal).json()
 val me = Api.Me(token.getString("eg_token")).json()
 val profile = me.getJSONObject("profile")
 
 return Session.Complete(
 egToken = token.getString("eg_token"),
 refreshToken = token.getString("refresh_token"),
 egId = me.getString("eg_id"),
 principal = me.getString("principal_of_client"),
 provider = profile.takeIf { !it.isNull("provider") }?.getString("provider"),
 email = profile.takeIf { !it.isNull("email") }?.getString("email"),
 userId = me.getString("user_id")
 )
 }
 
 private fun refreshToken(): Session.Complete {
 val session = _sessionRepo.session
 when (session) {
 is Token -> {
 val token = Api.Refresh(
 _platform.configuration.clientId,
 _platform.configuration.secret,
 _platform.configuration.region,
 _platform.deviceId,
 session.refreshToken,
 session.egToken
 ).json()
 val me = Api.Me(token.getString("eg_token")).json()
 val profile = me.getJSONObject("profile")
 
 return Session.Complete(
 egToken = token.getString("eg_token"),
 refreshToken = session.refreshToken,
 egId = me.getString("eg_id"),
 principal = me.getString("principal_of_client"),
 provider = profile.takeIf { !it.isNull("provider") }?.getString("provider"),
 email = profile.takeIf { !it.isNull("email") }?.getString("email"),
 userId = me.getString("user_id")
 )
 }
 else -> {
 throw Fail.TOKEN_EMPTY.with("There is any session token.")
 }
 }
 }
 
 
 
 private fun expireToken() {
 val token = _sessionRepo.session
 if (token is Token) {
 Api.Expire(token.egToken).json()
 }
 }
 
 private fun abandonAccount() {
 val session = _sessionRepo.session
 if (session is Token) {
 Api.Abandon(
 session.egToken,
 _platform.configuration.clientId,
 _platform.configuration.secret,
 _platform.configuration.region
 ).json()
 }
 }
 
 inner class Await internal constructor() {
 @JvmOverloads
 fun open(executor: Executor = PlainExecutor()): String = FutureTask<String> {
 when (_sessionRepo.hasSession) {
 false -> publishToken(exchangePrincipal(deviceIdentity))
 else -> refreshToken()
 }.run {
 _sessionRepo.session = this
 return@run this.egToken
 }
 }.apply {
 executor.execute(this)
 }.getOrThrow()
 
 @JvmOverloads
 fun create(principal: String? = null, executor: Executor = PlainExecutor()): String = FutureTask<String> {
 if (principal == null && _sessionRepo.hasSession) {
 throw Fail.ACCOUNT_SESSION_DUPLICATED.with("Guest session can not be duplicated. There is already a opened session.")
 }
 
 return@FutureTask publishToken(principal ?: exchangePrincipal(deviceIdentity)).run {
 _sessionRepo.session = this
 return@run egToken
 }
 }.apply {
 executor.execute(this)
 }.getOrThrow()
 
 @JvmOverloads
 fun resume(executor: Executor = PlainExecutor()): String = FutureTask<String> {
 refreshToken().run {
 _sessionRepo.session = this
 return@run egToken
 }
 }.apply {
 executor.execute(this)
 }.getOrThrow()
 
 @JvmOverloads
 fun sync(
 data: Map<String, Any>, principal: String? = null, force: Boolean = false,
 executor: Executor = PlainExecutor()
 ): Result = FutureTask<Result> {
 _sessionRepo.session.let { session ->
 when (session) {
 is Session.Complete -> synchronizeData(session.egToken, principal?: session.principal, data, force)
 else -> throw Fail.TOKEN_EMPTY.with("There is no complete session.")
 }.apply {
 if (this is Result.SyncComplete) {
 _sessionRepo.session = session.extend(
 egId = egId, principal = to,
 provider = data["provider"]?.run { this.toString() },
 email = data["email"]?.run { this.toString() })
 }
 }
 }
 }.apply {
 executor.execute(this)
 }.getOrThrow()
 
 @JvmOverloads fun expire(executor: Executor = PlainExecutor()) = executor.execute {
 expireToken()
 }
 
 @JvmOverloads fun signOut(executor: Executor = PlainExecutor()) {
 expire(executor)
 _sessionRepo.disconnectProvider()
 _sessionRepo.revoke()
 }
 
 @JvmOverloads fun revoke(executor: Executor = PlainExecutor()) = executor.execute {
 abandonAccount()
 _sessionRepo.disconnectProvider()
 _sessionRepo.revoke()
 }
 }
 
 private fun SessionRepository.disconnectProvider() {
 val session = session
 if (session is Session.Complete && session.provider != null) {
 ProviderControl
 .create(_platform as Context, Provider.valueOf(session.provider.toUpperCase()))
 .disconnect()
 }
 }
 }
 
 private fun JSONObject.toMap(): Map<String, Any> {
 var map = HashMap<String, Any>()
 this.keys().forEach {k -> map.put(k as String, this.get(k)) }
 return map
 }
 
 private fun Api.json(): JSONObject {
 try {
 val r = this.invoke()
 try {
 if (r.status == 200) {
 return JSONObject(String(r.content, Charsets.UTF_8))
 } else {
 var msg = JSONObject(String(r.content, Charsets.UTF_8))
 throw Fail.resolve(msg.getString("code"), msg.getString("message"))
 }
 } catch (e: JSONException) {
 throw Fail.API_UNKNOWN_RESPONSE.with("API Request Fail. - http response status : ${r.status}, message: ${r.message}")
 }
 } catch (e: EGException) {
 throw e
 } catch (e: Exception) {
 throw Fail.API_REQUEST_FAIL.with("API Request Failed!! : ${e.message}", e)
 }
 }
 
 private inline fun <V> Future<V>.getOrThrow(): V {
 try {
 return this.get()
 } catch (e: ExecutionException) {
 throw e.cause ?: e
 }
 }
 
 private fun Session.Complete.extend(
 egToken: String? = null,
 refreshToken: String? = null,
 egId: String? = null,
 principal: String? = null,
 provider: String? = null,
 email: String? = null,
 userId: String? = null
 ) = Session.Complete (
 egToken = egToken?: this.egToken,
 refreshToken = refreshToken?: this.refreshToken,
 egId = egId?: this.egId,
 principal = principal?: this.principal,
 provider = provider?: this.provider,
 email = email?: this.email,
 userId = userId?: this.userId
 )

 */
