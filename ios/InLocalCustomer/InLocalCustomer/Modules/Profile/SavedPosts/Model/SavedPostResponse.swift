//
//  SavedPostResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 30/10/21.
//

import ObjectMapper

struct SavedPostResponse: Mappable, Codable {
    
    var favoritePostList : [FavoritePostList]?
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        favoritePostList <- map["FavoritePostList"]
    }
}

struct FavoritePostList : Mappable, Codable {
    
    var id : Int?
    var restaurantId : Int?
    var menuItemId : Int?
    var message : String?
    var likeCounter : Int?
    var image : String?
    var postUserType : String?
    var active : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        restaurantId <- map["restaurant_id"]
        menuItemId <- map["menu_item_id"]
        message <- map["message"]
        likeCounter <- map["like_counter"]
        image <- map["image"]
        postUserType <- map["post_user_type"]
        active <- map["active"]
    }
}
