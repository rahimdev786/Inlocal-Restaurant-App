//
//  OrderListDependency.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import ObjectMapper

struct OrderListDependency : Mappable,Codable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        
    }
    
    
    var isComingFromUpload = false
    
    var data: [OrderListing]?
    
}

struct OrderListing : Mappable, Codable
{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        orderListing <- map["orderListing"]
        skip <- map["skip"]
        limit <- map["limit"]
        total <- map["total"]
    }
    
    var orderListing: [OrderListObjectData]?
    var skip:Int?
    var limit : Int?
    var total : Int?
    
}

struct OrderListObjectData :Mappable,Codable{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         id <- map["id"]
         customer_id <- map["customer_id"]
           restaurant_id <- map["restaurant_id"]
           order_status_id <- map["order_status_id"]
           order_type <- map["order_type"]
           percentage_tip_value <- map["percentage_tip_value"]
           order_date <- map["order_date"]
           table_no <- map["table_no"]
           no_of_guest <- map["no_of_guest"]
         transaction_id <- map["transaction_id"]
         payment_status <- map["payment_status"]
         payment_mode <- map["payment_mode"]
         order_subtotal <- map["order_subtotal"]
           delivery_charge <- map["delivery_charge"]
         tax <- map["tax"]
         discount_amount <- map["discount_amount"]
         final_order_amount <- map["final_order_amount"]
         order_commission <- map["order_commission"]
        
           note <- map["note"]
         message <- map["message"]
           created_at <- map["created_at"]
           updated_at <- map["updated_at"]
           order_status <- map["order_status"]
           order_items <- map["order_items"]
           restaurant <- map["restaurant"]
    }
    
    
    var id : Int?
    var customer_id : Int?
      var restaurant_id: Int?
      var order_status_id:Int?
      var order_type: String?
      var percentage_tip_value: Int?
      var order_date: String?
      var table_no: Int?
      var no_of_guest:Int?
    var transaction_id : String?
    var payment_status:String?
    var payment_mode : String?
    var order_subtotal:Double?
      var delivery_charge: Double?
    var tax : Double?
    var discount_amount : Double?
    var final_order_amount : Double?
    var order_commission : Double?
    
      var note: String?
    var message : String?
      var created_at: String?
      var updated_at: String?
      var order_status: OrderStatus?
      var order_items: [OrderedItem]?
      var restaurant: ResturantInfo?
    
}

struct OrderedItem : Mappable,Codable
{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        order_id <- map["order_id"]
        menu_item_id <- map["menu_item_id"]
        menu_item_name <- map["menu_item_name"]
        price <- map["price"]
        qty <- map["qty"]
        status <- map["status"]
        message <- map["message"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        orderitemssubaddon <- map["orderitemssubaddon"]
    }
    
    var id:Int?
  var order_id: Int?
  var menu_item_id: Int?
  var menu_item_name:String?
    var price:Int?
  var qty: Int?
    var status:String?
  var message: String?
  var created_at: String?
  var updated_at: String?
  var orderitemssubaddon: [OrderedItemAddOn]?
}

struct OrderedItemAddOn : Mappable,Codable
{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        order_item_id <- map["order_item_id"]
        addon_id <- map["addon_id"]
        addon_name <- map["addon_name"]
        sub_addon_id <- map["sub_addon_id"]
        sub_addon_name <- map["sub_addon_name"]
        price <- map["price"]
        qty <- map["qty"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
    var id : Int?
  var order_item_id:Int?
    var addon_id : Int?
  var addon_name:String?
    var sub_addon_id : Int?
  var sub_addon_name : String?
    var price : Double?
    var qty : Int?
  var created_at: String?
  var updated_at: String?
}


struct OrderStatus : Mappable,Codable
{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        value <- map["value"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
    var id:Int?
  var name: String?
  var value:String?
    var created_at:String?
    var updated_at:String?
}

struct ResturantInfo:Mappable,Codable
{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         id <- map["id"]
         name <- map["name"]
         email <- map["email"]
         phone <- map["phone"]
         profile_image <- map["profile_image"]
         cover_image <- map["cover_image"]
         owner_name <- map["owner_name"]
         owner_email <- map["owner_email"]
         owner_phone <- map["owner_phone"]
         description <- map["description"]
         address <- map["address"]
         latitue <- map["latitue"]
         logitute <- map["logitute"]
         zipcode <- map["zipcode"]
         city <- map["city"]
         country_code <- map["country_code"]
         country <- map["country"]
         landmark <- map["landmark"]
         device_token <- map["device_token"]
         restReservationAvailable <- map["restReservationAvailable"]
         restDeliveryAvailable <- map["restDeliveryAvailable"]
         mobile_verified <- map["mobile_verified"]
         commission_type <- map["commission_type"]
         commission_value <- map["commission_value"]
         delivery_charges <- map["delivery_charges"]
         delivery_note <- map["delivery_note"]
         favaourite_counter <- map["favaourite_counter"]
         like_counter <- map["like_counter"]
         followers <- map["followers"]
         followings <- map["followings"]
         posts_counter <- map["posts_counter"]
         insight_counter <- map["insight_counter"]
         status <- map["status"]
         created_at <- map["created_at"]
         updated_at <- map["updated_at"]
    }
    
    var id : Int?
    var name:String?
    var email:String?
    var phone: PhoneNumber?
    var profile_image : String?
    var cover_image:String?
    var owner_name:String?
    var owner_email:String?
    var owner_phone : String?
    var description : String?
    var address : String?
    var latitue:String?
    var logitute : String?
    var zipcode : String?
    var city :String?
    var country_code : String?
    var country: String?
    var landmark:String?
    
    var device_token:String?

    var restReservationAvailable : String?
    var restDeliveryAvailable : String?
    var mobile_verified :String?
    var commission_type : String?
    var commission_value : String?
    var delivery_charges: String?
    var delivery_note : String?
    var favaourite_counter : String?
    var like_counter : String?
    var followers : Int?
    var followings : Int?
    var posts_counter :Int?
    var insight_counter : Int?
    var status : String?
    var created_at:String?
    var updated_at:String?
    
  }

struct PhoneNumber:Mappable,Codable
{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        countryCode <- map["countryCode"]
        number <- map["number"]
    }
    
    var countryCode : String?
    var number:String?
}
