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
    case changePassword
    case updateProfile
    case logout
    case socialLogin
    case notificationList

    internal var path: String {
        
        switch self {
        case .register:
            return "/register"
        case .verifyRegistration:
            return "/verify/registration/otp"
        case .login:
            return "/customer/login"
        case .verifyOTP:
            return "/verify/otp"
        case .resendOTP:
            return "/resend/otp"
        case .forgotPassword:
            return "/forget/password"
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
