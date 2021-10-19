//
//  UserPostListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 18/10/21.
//

import ObjectMapper

struct UserPostListResponse: Mappable, Codable{
    
    var customerPostList : [CustomerPostList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        customerPostList <- map["CustomerPostList"]
    }
    
}

struct CustomerPostList: Mappable, Codable{
    
    var postId: Int?
    var postImage: String?
    var restaurantName: String?
    var restaurantImg: String?
    var restaurantId: Int?
    var menuItemId: Int?
    var message: String?
    var likeCounter: Int?
    var postUserType: String?
    var userPostBy: Int?
    var name: String?
    var profileImage: String?
    var isLiked: Bool?
    var isFavorite: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        postId <- map["post_id"]
        postImage <- map["post_image"]
        restaurantName <- map["restaurant_name"]
        restaurantImg <- map["restaurant_img"]
        restaurantId <- map["restaurant_id"]
        menuItemId <- map["menu_item_id"]
        message <- map["message"]
        likeCounter <- map["like_counter"]
        postUserType <- map["post_user_type"]
        name <- map["name"]
        profileImage <- map["profile_image"]
        isLiked <- map["isLiked"]
        isFavorite <- map["isFavorite"]
    }
}
