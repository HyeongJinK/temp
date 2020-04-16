//
//  Fail.swift
//  estgames-common-framework
//
//  Created by estgames on 2018. 6. 4..
//

import Foundation

@objc public enum Fail: Int {
    case START_API_NOT_CALL = 0    //기존 네트워크 에러 이름이 변경 되었습니다.
    case START_API_DATA_FAIL = 1
    case START_API_DATA_INIT = 2
    
    case PROCESS_DENIED_CONTRACT = 3
    
    case TOKEN_EMPTY = 4
    case TOKEN_CREATION = 5
    case TOKEN_INVALID = 6
    case TOKEN_EXPIRED = 7
    
    case CLIENT_UNKNOWN_PROVIDER = 8
    case CLIENT_NOT_REGISTERED = 9
    
    case API_REQUEST_FAIL = 10
    case API_ACCESS_DENIED = 11
    case API_OMITTED_PARAMETER = 12
    case API_UNSUPPORTED_METHOD = 13
    case API_BAD_REQUEST = 14
    case API_INCOMPATIBLE_VERSION = 15
    case API_CHARACTER_INFO = 16
    case API_UNKNOWN_RESPONSE = 17
    
    case ACCOUNT_NOT_EXIST = 18
    case ACCOUNT_ALREADY_EXIST = 19
    case ACCOUNT_INVALID_PROPERTY = 20
    case ACCOUNT_SYNC_FAIL = 21
    
    case SIGN_AWS_LOGIN_VIEW = 22
    case SIGN_GOOGLE_SDK = 23
    case SIGN_FACEBOOK_SDK = 24
    case SIGN_AWS_SESSION = 25
    
    case GOOGLE_CALLBACK_EMPTY = 26
    
    public var describe: String {
        switch self.rawValue {
        case 0:
            return "START_API_NOT_CALL"
        case 1:
            return "START_API_DATA_FAIL"
        case 2:
            return "START_API_DATA_INIT"
        case 3:
            return "PROCESS_DENIED_CONTRACT"
        case 4:
            return "TOKEN_EMPTY"
        case 5:
            return "TOKEN_CREATION"
        case 6:
            return "TOKEN_INVALID"
        case 7:
            return "TOKEN_EXPIRED"
        case 8:
            return "CLIENT_UNKNOWN_PROVIDER"
        case 9:
            return "CLIENT_NOT_REGISTERED"
        case 10:
            return "API_REQUEST_FAIL"
        case 11:
            return "API_ACCESS_DENIED"
        case 12:
            return "API_OMITTED_PARAMETER"
        case 13:
            return "API_UNSUPPORTED_METHOD"
        case 14:
            return "API_BAD_REQUEST"
        case 15:
            return "API_INCOMPATIBLE_VERSION"
        case 16:
            return "API_CHARACTER_INFO"
        case 17:
            return "API_UNKNOWN_RESPONSE"
        case 18:
            return "ACCOUNT_NOT_EXIST"
        case 19:
            return "ACCOUNT_ALREADY_EXIST"
        case 20:
            return "ACCOUNT_INVALID_PROPERTY"
        case 21:
            return "ACCOUNT_SYNC_FAIL"
        case 22:
            return "SIGN_AWS_LOGIN_VIEW"
        case 23:
            return "SIGN_GOOGLE_SDK"
        case 24:
            return "SIGN_FACEBOOK_SDK"
        case 25:
            return "SIGN_AWS_SESSION"
        case 26:
            return "GOOGLE_CALLBACK_EMPTY"
        default:
            return ""
        }
    }
}
