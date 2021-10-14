//
//  FeedWallListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 08/10/21.
//

import ObjectMapper

struct FeedWallListResponse : Mappable, Codable {
    var feedWallListing: [FeedwallListing]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        feedWallListing <- map["MyFeedWallPosts"]
    }
}

struct FeedwallListing: Mappable, Codable {
    
    var postId: Int?
    var restaurantId: Int?
    var postUserType: String?
    var userPostBy: Int?
    var menuItemId: Int?
    var message: String?
    var likeCounter: Int?
    var postImage: String?
    var name: String?
    var profileImage: String?
    var isLiked: Bool?
    var isFavorite: Bool?
    var restaurantImg: String?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        postId <- map["post_id"]
        restaurantId <- map["restaurant_id"]
        postUserType <- map["post_user_type"]
        userPostBy <- map["user_post_by"]
        menuItemId <- map["menu_item_id"]
        message <- map["message"]
        likeCounter <- map["like_counter"]
        postImage <- map["post_image"]
        name <- map["name"]
        profileImage <- map["profile_image"]
        isLiked <- map["isLiked"]
        isFavorite <- map["isFavorite"]
        restaurantImg <- map["restaurant_img"]
    }
}

