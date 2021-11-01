//
//  NotificationSettingResponseModel.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/10/21.
//

import ObjectMapper

struct NotificationSettingResponseModel: Mappable, Codable {
    
    var id: String?
    var customerId: String?
    var post: String?
    var stories: String?
    var comments: String?
    var followers: String?
    var orders: String?
    var booking: String?
    var payment: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        customerId <- map["customer_id"]
        post <- map["post"]
        stories <- map["stories"]
        comments <- map["comments"]
        followers <- map["followers"]
        orders <- map["orders"]
        booking <- map["bookings"]
        payment <- map["payment"]
    }
}

struct UpdateSettingResponse : Mappable, Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        code <- map["code"]
        message <- map["message"]
    }
}


