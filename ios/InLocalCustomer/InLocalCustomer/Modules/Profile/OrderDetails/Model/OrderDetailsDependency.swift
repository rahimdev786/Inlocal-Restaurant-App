//
//  OrderDetailsDependency.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

struct OrderDetailsDependency {
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import ObjectMapper

// MARK: - Welcome
struct OrderDetailsModel: Mappable,Codable {
    
    var success: Bool?
    var code: Int?
    var message: String?
    var data: OrderDetailsDataClass?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["success"]
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
        
    }
}

// MARK: - DataClass
struct OrderDetailsDataClass: Mappable,Codable {
    var orderDetail: OrderDetail?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        orderDetail <- map["orderDetail"]
    }
}

// MARK: - OrderDetail
struct OrderDetail: Mappable,Codable {
    var id, customerID, restaurantID, orderStatusID: Int?
    var orderType: String?
    var percentageTipValue: String?
    var orderDate: String?
    var tableNo, noOfGuest: Int?
    var transactionID: String?
    var paymentStatus: String?
    var paymentMode: String?
    var orderSubtotal, deliveryCharge, tax, discountAmount: Int?
    var finalOrderAmount, orderCommission: Int?
    var note, message, createdBy, updatedBy: String?
    var deletedBy: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var orderStatus: OrderStatus?
    var orderItems: [OrderItem]?
    var orderDeliveryDetail: String?
    var restaurant: Restaurant?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        customerID <- map["customer_id"]
        restaurantID <- map["restaurant_id"]
        orderStatusID <- map["order_status_id"]
        orderType <- map["order_type"]
        percentageTipValue <- map["percentage_tip_value"]
        orderDate <- map["order_date"]
        tableNo <- map["table_no"]
        noOfGuest <- map["no_of_guest"]
        transactionID <- map["transaction_id"]
        paymentStatus <- map["payment_status"]
        paymentMode <- map["payment_mode"]
        orderSubtotal <- map["order_subtotal"]
        deliveryCharge <- map["delivery_charge"]
        tax <- map["tax"]
        discountAmount <- map["discount_amount"]
        finalOrderAmount <- map["final_order_amount"]
        orderCommission <- map["order_commission"]
        note <- map["note"]
        message <- map["message"]
        createdBy <- map["created_by"]
        updatedBy <- map["updated_by"]
        deletedBy <- map["deleted_by"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        deletedAt <- map["deleted_at"]
        orderStatus <- map["order_status"]
        orderItems <- map["order_items"]
        orderDeliveryDetail <- map["order_delivery_detail"]
        restaurant <- map["restaurant"]
    }
}

// MARK: - OrderItem
struct OrderItem:Mappable, Codable {
    var id, orderID, menuItemID: Int?
    var menuItemName: String?
    var price, qty: Int?
    var status: String?
    var message: String?
    var createdAt, updatedAt: String?
    var menuItemImage: String?
    var orderItemDescription: String?
    var orderitemssubaddon: [Orderitemssubaddon]?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
       id <- map["id"]
       orderID <- map["order_id"]
       menuItemID <- map["menu_item_id"]
       menuItemName <- map["menu_item_name"]
       price <- map["price"]
       qty <- map["qty"]
       status <- map["status"]
       message <- map["message"]
       createdAt <- map["created_at"]
       updatedAt <- map["updated_at"]
       menuItemImage <- map["menu_item_image"]
       orderItemDescription <- map["description"]
       orderitemssubaddon <- map["orderitemssubaddon"]
    }
}

// MARK: - Orderitemssubaddon
struct Orderitemssubaddon:Mappable, Codable {
    var id, orderItemID, addonID: Int?
    var addonName: String?
    var subAddonID: Int?
    var subAddonName: String?
    var price, qty: Int?
    var createdAt, updatedAt: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        orderItemID <- map["order_item_id"]
        addonID <- map["addon_id"]
        addonName <- map["addon_name"]
        subAddonID <- map["sub_addon_id"]
        subAddonName <- map["sub_addon_name"]
        price <- map["price"]
        qty <- map["qty"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}

// MARK: - OrderStatus
struct OrderStatus:Mappable, Codable {
    var id: Int?
    var name, value, createdAt, updatedAt: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        value <- map["value"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}

// MARK: - Restaurant
struct Restaurant: Mappable,Codable {
    var id: Int?
    var name, email: String?
    var phone: Phone?
    var profileImage, coverImage, ownerName, ownerEmail: String?
    var ownerPhone, restaurantDescription, address, latitue: String?
    var logitute, zipcode, city, countryCode: String?
    var country, landmark: String?
    var otp: String?
    var deviceToken, deviceType, deviceID: String?
    var pwdResetToken: String?
    var restReservationAvailable, restDeliveryAvailable, mobileVerified, commissionType: String?
    var commissionValue, deliveryCharges, deliveryNote: String?
    var favaouriteCounter, likeCounter: String?
    var followers, followings, postsCounter, insightCounter: Int?
    var status: String?
    var createdBy: Int?
    var updatedBy, deletedBy: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
                
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        profileImage <- map["profile_image"]
        coverImage <- map["cover_image"]
        ownerName <- map["owner_name"]
        ownerEmail <- map["owner_email"]
        ownerPhone <- map["owner_phone"]
        restaurantDescription <- map["description"]
        address <- map["address"]
        latitue <- map["latitue"]
        logitute <- map["logitute"]
        zipcode <- map["zipcode"]
        city <- map["city"]
        countryCode <- map["country_code"]
        country <- map["country"]
        landmark <- map["landmark"]
        otp <- map["otp"]
        deviceToken <- map["device_token"]
        deviceType <- map["device_type"]
        deviceID <- map["device_id"]
        pwdResetToken <- map["pwd_reset_token"]
        restReservationAvailable <- map["restReservationAvailable"]
        restDeliveryAvailable <- map["restDeliveryAvailable"]
        mobileVerified <- map["mobile_verified"]
        commissionType <- map["commission_type"]
        commissionValue <- map["commission_value"]
        deliveryCharges <- map["delivery_charges"]
        deliveryNote <- map["delivery_note"]
        favaouriteCounter <- map["favaourite_counter"]
        likeCounter <- map["like_counter"]
        followers <- map["followers"]
        followings <- map["followings"]
        postsCounter <- map["posts_counter"]
        insightCounter <- map["insight_counter"]
        status <- map["status"]
        createdBy <- map["created_by"]
        updatedBy <- map["updated_by"]
        deletedBy <- map["deleted_by"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        deletedAt <- map["deleted_at"]
    }
}
