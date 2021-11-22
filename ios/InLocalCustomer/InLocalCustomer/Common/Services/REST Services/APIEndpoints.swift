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
    case setDefaultAddress
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
        case .setDefaultAddress:
            return "/customer/address/set_default"
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
        case .setDefaultAddress:
            return .post
        }
    }
}

enum NotificationEndpoints: APIEndpoint{
    
    case getList
    case updateSetting
    case notificationList
    case reatNotification
    
    var path: String{
        switch self {
        case .getList:
            return "/customer/notification/setting"
        case .updateSetting:
            return "/customer/notify/setting/update"
        case .notificationList:
            return "/common/notification/list"
        case .reatNotification:
            return "/common/notification/read"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getList:
            return .get
        case .updateSetting:
            return .post
        case .notificationList:
            return .post
        case .reatNotification:
            return .post
        }
    }
}

enum HomeEndpoints: APIEndpoint{
    case getStoryFeedList
    case getFeedList
    case likePost
    case savePost
    case getRestaurentDeatils
    case getRestaurantPostList
    case getCustomerDetails
    case getCustomerPostList
    case createStory
    case menuCategoryList
    case menuList
    case menuDetail
    case commentList
    case addCommnet
    case getSavedPost
    case addToCart
    case getCart
    case getFollowerList
    
    var path: String{
        switch self {
        case .getStoryFeedList:
            return "/common/story/feedwall/list"
        case .getFeedList:
            return "/common/post/feedwall/list"
        case .likePost:
            return "/common/post/like"
        case .savePost:
            return "/common/post/favorite"
        case .getRestaurentDeatils:
            return "/restaurant/details"
        case .getRestaurantPostList:
            return "/restaurant/post/list"
        case .getCustomerDetails:
            return "/customer/details"
        case .getCustomerPostList:
            return "/customer/post/list"
        case .createStory:
            return "/common/story/create"
        case .menuCategoryList:
            return "/menu_category/list"
        case .menuList:
            return "/menu/list"
        case .menuDetail:
            return "/menu/details"
        case .commentList:
            return "/common/comment/list"
        case .addCommnet:
            return "/common/comment/create"
        case .getSavedPost:
            return "/common/post/favorite/list"
        case .addToCart:
            return "/cart/add"
        case .getCart:
            return "/cart/get"
        case .getFollowerList:
            return "/common/myfollower/list"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getStoryFeedList:
            return .post
        case .getFeedList:
            return .post
        case .likePost:
            return .post
        case .savePost:
            return .post
        case .getRestaurentDeatils:
            return .post
        case .getRestaurantPostList:
            return .post
        case .getCustomerDetails:
            return .post
        case .getCustomerPostList:
            return .post
        case .createStory:
            return .post
        case .menuCategoryList:
            return .post
        case .menuList:
            return .post
        case .menuDetail:
            return .post
        case .commentList:
            return .post
        case .addCommnet:
            return .post
        case .getSavedPost:
            return .post
        case .addToCart:
            return .post
        case .getCart:
            return .post
        case .getFollowerList:
            return .post
        }
    }
}
