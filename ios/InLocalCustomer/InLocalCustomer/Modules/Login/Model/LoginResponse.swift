//
//  LoginResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import ObjectMapper

struct LoginResponseModel : Mappable, Codable {
    
    var token : String!
    var notificationSettings : NotificationSettings?
    var user : User?
    
    init?(map: Map) {
        guard let _ = map.JSON["token"] else{
            return
        }
    }

    mutating func mapping(map: Map) {
        token <- map["token"]
        notificationSettings <- map["notificationSettings"]
        user <- map["user"]
    }

}

struct NotificationSettings: Mappable, Codable {
    var post: Bool?
    var stories: Bool?
    var comments: Bool?
    var followers: Bool?
    var orders: Bool?
    var bookings: Bool?
    var payment: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        post <- map["post"]
        stories <- map["stories"]
        comments <- map["comments"]
        followers <- map["followers"]
        orders <- map["orders"]
        bookings <- map["bookings"]
        payment <- map["payment"]
    }
}

struct User: Mappable, Codable{
    var _id: String?
    var mobile_verified: String?
    var personalInfo: PersonalInfo?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        _id <- map["_id"]
        mobile_verified <- map["mobile_verified"]
        personalInfo <- map["personalInfo"]
    }
}

struct PersonalInfo : Mappable, Codable {

    var fullname: String?
    var email: String?
    var profilePicture: String?
    var phone: Phone?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        fullname <- map["fullname"]
        email <- map["email"]
        profilePicture <- map["profilePicture"]
        phone <- map["phone"]
    }
    
}

struct Phone : Mappable, Codable{
    var countryCode: String?
    var number: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map){
        countryCode <- map["countryCode"]
        number <- map["number"]
    }
}
