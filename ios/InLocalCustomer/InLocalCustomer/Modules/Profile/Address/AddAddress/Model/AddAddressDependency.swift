//
//  AddAddressDependency.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import ObjectMapper

struct AddAddressDependency {

}

struct AddAddressRequest {
    
    var flatNo: String?
    var landmark: String?
    var zipCode: String?
    var city:  String?
    var country: String?
    var countryName: String?
    var latitude: String?
    var longitude: String?
}

struct AddAddressResponse: Mappable, Codable {
    
    var success: Bool?
    var errorCode: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        errorCode <- map["errorCode"]
    }

}

