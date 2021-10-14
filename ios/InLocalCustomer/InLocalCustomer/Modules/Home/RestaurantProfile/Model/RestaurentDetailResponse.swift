//
//  RestaurentDetailResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 13/10/21.
//

import Foundation
import ObjectMapper

struct RestaurentDetailResponse: Mappable, Codable{
    var restaurantDetails: RestaurantDetails?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        restaurantDetails <- map["restaurantDetails"]
    }
}

struct RestaurantDetails: Mappable, Codable {
    
    var restaurentId: Int?
    var name: String?
    var email: String?
    var profilePicture: String?
    var coverImage: String?
    var description: String?
    var address: String?
    var zipcode: String?
    var insightCounter: Int?
    var postsCounter: Int?
    var followings: Int?
    var followers: Int?
    var restDeliveryAvailable: String?
    var restReservationAvailable: String?
    var isFollow: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        restaurentId <- map["restaurant_id"]
        name <- map["name"]
        email <- map["email"]
        profilePicture <- map["profilePicture"]
        coverImage <- map["cover_image"]
        description <- map["description"]
        address <- map["address"]
        zipcode <- map["zipcode"]
        insightCounter <- map["insight_counter"]
        postsCounter <- map["posts_counter"]
        followings <- map["followings"]
        followers <- map["followers"]
        restDeliveryAvailable <- map["restDeliveryAvailable"]
        restReservationAvailable <- map["restReservationAvailable"]
        isFollow <- map["IsFollow"]
    }
}
