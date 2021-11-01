//
//  NotificationListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 31/10/21.
//

import ObjectMapper

struct NotificationListResponse : Mappable, Codable {
    
    var notificationList : [NotificationList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        notificationList <- map["notificationList"]
    }
}

struct NotificationList : Mappable, Codable{
    var id: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
    }
}

