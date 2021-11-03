//
//  AddToCartResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/11/21.
//

import ObjectMapper

struct AddToCartResponse: Mappable, Codable {
    
    var cartId : Int?
    var cartTotal: String?
    var cartItemCount: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cartId <- map["cart_id"]
        cartTotal <- map["carttotal"]
        cartItemCount <- map["cartitemcnt"]
    }
}

