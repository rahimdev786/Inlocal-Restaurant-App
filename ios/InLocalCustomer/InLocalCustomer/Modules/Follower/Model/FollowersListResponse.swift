//
//  FollowersListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 21/11/21.
//

import ObjectMapper

struct FollowersListResponse: Mappable, Codable {
    var myFollowerList : [MyFollowerList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        myFollowerList <- map["MyFollowerList"]
    }
}

struct MyFollowerList: Mappable, Codable {
    var id: Int?
    var name: String?
    var profileimage: String?
    var userType: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profileimage <- map["profileimage"]
        userType <- map["user_type"]
    }
}
