//
//  MenuDetailResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 20/10/21.
//

import ObjectMapper

struct  MenuDetailResponse: Mappable, Codable  {
    var menuItemDetails : MenuListing?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        menuItemDetails <- map["MenuItemDetails"]
    }
}

/*
struct MenuItemDetails: Mappable, Codable {
    var id : Int?
    var name : String?
    var description : String?
    var image : String?
    var price : String?
    var eatInsideAvailable : String?
    var deliveryAvailable : String?
    var active: String?
    var cartQty : Int?
    var inInCart : Bool?
    var customizeList: [CustomizeList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        image <- map["image"]
        price <- map["price"]
        eatInsideAvailable <- map["EatInsideAvailable"]
        deliveryAvailable <- map["DeliveryAvailable"]
        active <- map["active"]
        cartQty <- map["cartQty"]
        inInCart <- map["inInCart"]
        customizeList <- map["customizeList"]
        
    }
}
*/
