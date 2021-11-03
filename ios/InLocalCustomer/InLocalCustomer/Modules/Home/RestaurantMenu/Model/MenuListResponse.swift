//
//  File.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 20/10/21.
//

import ObjectMapper

struct MenuListResponse: Mappable, Codable  {
    
    var menuListing : [MenuListing]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        menuListing <- map["menuListing"]
    }
}

struct MenuListing: Mappable, Codable {
    var id : Int?
    var name: String?
    var description: String?
    var image: String?
    var price: String?
    var active: String?
    var cartQty: Int?
    var inInCart: Bool?
    var customizeList: [CustomizeList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        image <- map["image"]
        price <- map["price"]
        active <- map["active"]
        cartQty <- map["cartQty"]
        inInCart <- map["inInCart"]
        customizeList <- map["customizeList"]
    }
}

struct CustomizeList: Mappable, Codable {
    var id: Int?
    var menuItemId: Int?
    var title: String?
    var isMulti: String?
    var active: String?
    var menuitemsubaddon: [MenuItemSubAddon]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        menuItemId <- map["menu_item_id"]
        title <- map["title"]
        isMulti <- map["active"]
        menuitemsubaddon <- map["menuitemsubaddon"]
    }
}

struct MenuItemSubAddon: Mappable, Codable {
    var id: Int?
    var addOnId: Int?
    var name: String?
    var price: String?
    var active : String?
    var isSelectedInCart : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        addOnId <- map["addon_id"]
        name <- map["name"]
        price <- map["price"]
        active <- map["active"]
        isSelectedInCart <- map["isSelectedInCart"]
    }
}
