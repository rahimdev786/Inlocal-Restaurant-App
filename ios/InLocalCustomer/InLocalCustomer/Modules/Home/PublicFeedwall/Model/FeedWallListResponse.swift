//
//  FeedWallListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 08/10/21.
//

import ObjectMapper

struct FeedWallListResponse : Mappable, Codable {
    var feedwallListing: [FeedwallListing]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        feedwallListing <- map["feedwallListing"]
    }
}

struct FeedwallListing: Mappable, Codable {
    
    var id: String?
    var desc: String?
    var photoUrl: String?
    var isFav: String?
    var favCount: String?
    var personInfo: PersonInfo?
    var restauruntDetails : RestaurentDetails?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        desc <- map["desc"]
        photoUrl <- map["photoUrl"]
        isFav <- map["isFav"]
        favCount <- map["favCount"]
        personInfo <- map["personInfo"]
        restauruntDetails <- map["restauruntDetails"]
    }
}

struct PersonInfo: Mappable, Codable{
    
    var name: String?
    var id: String?
    var profilePhoto: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        profilePhoto <- map["profilePhoto"]
    }
}

struct RestaurentDetails : Mappable, Codable{
    var id: String?
    var name: String?
    var address: String?
    var photo: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        address <- map["adr"]
        photo <- map["photo"]
    }
}
