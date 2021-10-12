//
//  ChangePasswordResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 08/10/21.
//

import ObjectMapper

struct ChangePasswordResponse : Mappable, Codable {
    var success: Bool?
    var errorCode: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        errorCode <- map["errorCode"]
    }
}

