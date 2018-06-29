//
//  Fail.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 6. 4..
//

import Foundation

@objc public enum Fail: Int {
    case START_API_NOT_CALL    //기존 네트워크 에러 이름이 변경 되었습니다.
    case START_API_DATA_FAIL
    case START_API_DATA_INIT
    
    case PROCESS_DENIED_CONTRACT
    
    case TOKEN_EMPTY
    case TOKEN_CREATION
    case TOKEN_INVALID
    case TOKEN_EXPIRED
    
    case CLIENT_UNKNOWN_PROVIDER
    case CLIENT_NOT_REGISTERED
    
    case API_REQUEST_FAIL
    case API_ACCESS_DENIED
    case API_OMITTED_PARAMETER
    case API_UNSUPPORTED_METHOD
    case API_BAD_REQUEST
    case API_INCOMPATIBLE_VERSION
    case API_CHARACTER_INFO
    case API_UNKNOWN_RESPONSE
    
    case ACCOUNT_NOT_EXIST
    case ACCOUNT_ALREADY_EXIST
    case ACCOUNT_INVALID_PROPERTY
    case ACCOUNT_SYNC_FAIL
    
    case SIGN_AWS_LOGIN_VIEW
    case SIGN_GOOGLE_SDK
    case SIGN_FACEBOOK_SDK
    case SIGN_AWS_SESSION
    
    case GOOGLE_CALLBACK_EMPTY
}
