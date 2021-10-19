//
//  CustomerDetailResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 14/10/21.
//

import ObjectMapper

struct CustomerDetailResponse: Mappable, Codable {
    var customerDetails: CustomerDetails?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        customerDetails <- map["customerDetails"]
    }
    
}

struct CustomerDetails: Mappable, Codable {
    var customerId: Int?
    var name: String?
    var profilePicture: String?
    var insightCounter: Int?
    var postsCounter: Int?
    var followings: Int?
    var followers: Int?
    var isFollower: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        customerId <- map["customer_id"]
        name <- map["name"]
        profilePicture <- map["profilePicture"]
        insightCounter <- map["insight_counter"]
        postsCounter <- map["posts_counter"]
        followings <- map["followings"]
        followers <- map["followers"]
        isFollower <- map["isFollower"]
    }
}

