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
    var customerId : Int?
    var address : String?
    var landmark : String?
    var city : String?
    var zipCode : String?
    var country : String?
    var countryCode : String?
    var isDefault : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        customerId <- map["customer_id"]
        address <- map["address"]
        landmark <- map["landmark"]
        city <- map["city"]
        zipCode <- map["zipcode"]
        country <- map["country"]
        countryCode <- map["countryCOde"]
        isDefault <- map["isDefault"]
    }
}

