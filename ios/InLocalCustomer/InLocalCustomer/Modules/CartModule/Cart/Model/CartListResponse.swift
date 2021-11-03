//
//  CartListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 03/11/21.
//

import ObjectMapper

struct CartListResponse: Mappable, Codable {
    
    var cartorderdetail : Cartorderdetail?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        cartorderdetail <- map["cartorderdetail"]
    }
}

struct Cartorderdetail: Mappable, Codable {
    
    var id : Int?
    var customerId: Int?
    var restaurantId: Int?
    var customerAddrId: Int?
    var cartSubTotal: String?
    var deliveryCharge: String?
    var tax: String?
    var discountAmount: String?
    var cartitems : [Cartitems]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        customerId <- map["customer_id"]
        restaurantId <- map["restaurant_id"]
        customerAddrId <- map["customer_addr_id"]
        cartSubTotal <- map["cart_sub_total"]
        deliveryCharge <- map["delivery_charge"]
        tax <- map["tax"]
        discountAmount <- map["discount_amount"]
        cartitems <- map["cartitems"]
    }
}

struct Cartitems: Mappable, Codable {
    var id: Int?
    var cartId: Int?
    var customerId: Int?
    var restaurantId: Int?
    var menuItemId : Int?
    var menuItemName : String?
    var price : String?
    var quantity: Int?
    var description: String?
    var cartItemsSubAddon : [CartItemsSubAddon]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cartId <- map["cart_id"]
        customerId <- map["customer_id"]
        restaurantId <- map["restaurant_id"]
        menuItemId <- map["menu_item_id"]
        menuItemName <- map["menu_item_name"]
        price <- map["price"]
        quantity <- map["qty"]
        description <- map["description"]
        cartItemsSubAddon <- map["cartitemssubaddon"]
    }
}

struct CartItemsSubAddon : Mappable, Codable {
    
    var id: Int?
    var cartItemId: Int?
    var addonId : Int?
    var addonName : String?
    var subAddonId : Int?
    var subAddonName : String?
    var price : String?
    var qty : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cartItemId <- map["cart_item_id"]
        addonId <- map["addon_id"]
        addonName <- map["addon_name"]
        subAddonId <- map["sub_addon_id"]
        subAddonName <- map["sub_addon_name"]
        price <- map["price"]
        qty <- map["qty"]
    }
}

