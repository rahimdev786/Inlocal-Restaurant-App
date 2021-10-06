//
//  SignupResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 29/09/21.
//

import ObjectMapper

struct SignupResponse: Mappable, Codable {
    var id: String?
    var otp: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        otp <- map["otp"] 
    }
}

