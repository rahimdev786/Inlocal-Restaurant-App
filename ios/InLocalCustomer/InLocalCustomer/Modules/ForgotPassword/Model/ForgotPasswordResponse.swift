//
//  ForgotPasswordResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 30/09/21.
//

import ObjectMapper

struct ForgotPasswordResponse: Mappable, Codable {
    var id : Int?
    var otp: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        otp <- map["otp"]
    }
}

