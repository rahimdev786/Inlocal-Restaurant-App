//
//  ForgotPasswordResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 30/09/21.
//

import ObjectMapper

struct ForgotPasswordResponse: Mappable, Codable {
    var id : String?
    var otp: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        otp <- map["otp"]
    }
}


struct ForgotPasswordVerifyOTPResponse: Mappable, Codable {
    var message: String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
    }
}

