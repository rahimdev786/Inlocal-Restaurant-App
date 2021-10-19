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
            return "/customer/changepassword"
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


enum AddressEndpoints: APIEndpoint{
    case addressList
    case delete
    case addAddress
    case validAddress
    case edit
    
    var path: String{
        switch self {
        case .addAddress:
            return "/customer/address/add"
        case .delete:
            return "/delete/address"
        case .addressList:
            return "/customer/address/list"
        case .validAddress:
            return "/directory/countries"
        case .edit:
            return "/edit/address"
            
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .addAddress:
            return .post
        case .delete:
            return .post
        case .addressList:
            return .post
        case .validAddress:
            return .get
        case .edit:
            return .post
        }
    }
}

enum NotificationEndpoints: APIEndpoint{
    case getList
    case updateSetting
    
    var path: String{
        switch self {
        case .getList:
            return "/customer/notification/setting"
        case .updateSetting:
            return "/customer/notify/setting/update"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getList:
            return .get
        case .updateSetting:
            return .post
        }
    }
}

enum HomeEndpoints: APIEndpoint{
    case getStoryFeedList
    case getFeedList
    case getRestaurentDeatils
    case getRestaurantPostList
    case getCustomerDetails
    case getCustomerPostList
    var path: String{
        switch self {
        case .getStoryFeedList:
            return "/common/story/feedwall/list"
        case .getFeedList:
            return "/common/post/feedwall/list"
        case .getRestaurentDeatils:
            return "/restaurant/details"
        case .getRestaurantPostList:
            return "/restaurant/post/list"
        case .getCustomerDetails:
            return "/customer/details"
        case .getCustomerPostList:
            return "/customer/post/list"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getStoryFeedList:
            return .post
        case .getFeedList:
            return .post
        case .getRestaurentDeatils:
            return .post
        case .getRestaurantPostList:
            return .post
        case .getCustomerDetails:
            return .post
        case .getCustomerPostList:
            return .post
        }
    }
}
