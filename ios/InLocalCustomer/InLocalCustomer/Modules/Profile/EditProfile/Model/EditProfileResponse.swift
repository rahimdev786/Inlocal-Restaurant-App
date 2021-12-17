//
//  EditProfileResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 30/11/21.
//

import Foundation
import ObjectMapper

struct EditProfileResponse : Mappable, Codable {
    
    var customerDetails : EditedCustomerDetails?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        customerDetails <- map["customerDetails"]
    }
}

struct EditedCustomerDetails : Mappable, Codable {
    
    var customerId : Int?
    var name : String?
    var email : String?
    var phone : String?
    var profilePicture : String?
    var insightCounter : Int?
    var postsCounter : Int?
    var followings : Int?
    var followers  :Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        customerId <- map["customer_id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        profilePicture <- map["profilePicture"]
        insightCounter <- map["insight_counter"]
        postsCounter <- map["posts_counter"]
        followings <- map["followings"]
        followers <- map["followers"]
    }
}

