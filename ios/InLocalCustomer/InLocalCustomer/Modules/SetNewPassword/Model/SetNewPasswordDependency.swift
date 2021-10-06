//
//  SetNewPasswordDependency.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import ObjectMapper

struct SetNewPasswordDependency {

}

struct SetNewPasswordRequest {
    var newPassword: String?
    var conformPassword: String?
}

struct SetNewPasswordResponse: Mappable, Codable {
    var message: String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
    }
}

/*
{
  "success": true,
  "code": 200,
  "message": "Password reset successfully."
}
*/
