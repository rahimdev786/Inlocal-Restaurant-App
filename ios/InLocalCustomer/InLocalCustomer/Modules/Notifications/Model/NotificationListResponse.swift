//
//  NotificationListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 31/10/21.
//

import ObjectMapper

struct NotificationListModel:Mappable, Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var data: NotificationListResponse?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
    
}

struct NotificationListResponse : Mappable, Codable {
    
    var notificationList : [NotificationList]?
    var total, limit, skip: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        notificationList <- map["notificationList"]
        total <- map["total"]
        limit <- map["limit"]
        skip <- map["skip"]
    }
}

struct NotificationList : Mappable, Codable{
    var id: Int?
    var title, message: String?
    var readStatus: Int?
    var createdAt: String?
    var fromID, toID: Int?
    var moduleType, userType: String?
    var fromImage: String?
    var redirectionID: Int?
    var time: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        message <- map["message"]
        readStatus <- map["read_status"]
        createdAt <- map["created_at"]
        fromID <- map["from_id"]
        toID <- map["to_id"]
        moduleType <- map["module_type"]
        userType <- map["user_type"]
        fromImage <- map["from_image"]
        redirectionID <- map["redirection_id"]
        time <- map["time"]
    }
}

