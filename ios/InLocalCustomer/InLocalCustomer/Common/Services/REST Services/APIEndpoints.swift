//
//  APIEndpoints.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import Foundation
import Alamofire

public protocol APIEndpoint {
    
    var path: String {get}
    var method: HTTPMethod {get}
}

extension APIEndpoint {
    
    var urlPath: String {
        return ServerConfig.baseURL + path
    }
}


enum AuthenticationEndpoints: APIEndpoint {
    
    case register
    case verifyRegistration
    case login
    case verifyOTP
    case resendOTP
    case forgotPassword
    case setNewPassword
    case changePassword
    case updateProfile
    case logout
    case socialLogin
    case notificationList

    internal var path: String {
        
        switch self {
        case .register:
            return "/customer/signup"
        case .verifyRegistration:
            return "/customer/verifyotp"
        case .login:
            return "/customer/login"
        case .verifyOTP:
            return "/customer/forgot/verifyotp"
        case .resendOTP:
            return "/resend/otp"
        case .forgotPassword:
            return "/customer/forgotpassword"
        case .setNewPassword:
            return "/customer/resetpassword"
        case .changePassword:
            return "/change/password"
        case .updateProfile:
            return "/update/profile"
        case .logout:
            return "/logout"
        case .socialLogin:
            return "/social/login"
        case .notificationList:
            return "/get/notification"
        }
}

var method: HTTPMethod {
        
        switch self {
        case .register:
            return .post
        case .verifyRegistration:
            return .post
        case .login:
            return .post
        case .verifyOTP:
            return .post
        case .resendOTP:
            return .post
        case .forgotPassword:
            return .post
        case .setNewPassword:
            return .post
        case .changePassword:
            return .post
        case .updateProfile:
            return .post
        case .logout:
            return .post
        case .socialLogin:
            return .post
        case .notificationList:
            return .post
        }
    }
}
