//
//  AddressBookResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 06/10/21.
//

import ObjectMapper

struct AddressBookResponseModel: Mappable, Codable {
    
    var addressList : [AddressList]?
   
    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        addressList <- map["addressList"]
    }

}

struct AddressList: Mappable, Codable {
    
    var id : Int?
    var houseNo : String?
    var landmark : String?
    var zipCode : String?
    var city : String?
    var countryCode : String?
    var isDefault : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        houseNo <- map["house_no"]
        landmark <- map["landmark"]
        zipCode <- map["zipcode"]
        city <- map["city"]
        countryCode <- map["countryCOde"]
        isDefault <- map["isDefault"]
    }
}

