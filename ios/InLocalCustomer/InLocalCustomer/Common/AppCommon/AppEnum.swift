//
//  AppEnum.swift
//  InstaExpress
//
//  Created by sudipta patel on 11/02/21.
//  Copyright © 2021 Sudipta Patel. All rights reserved.
//

import Foundation

enum ProductShowType: Int {
    case image = 1
    case youtubeVideo = 2
}

enum ProductDeliveryType: Int {
    case onDemand = 1
    case standard = 2
}

enum CheckoutType {
    case delivery
    case pickup
}

enum PickerType: Int {
    case city = 0, deliveryType, timeSlot
}

enum DeliveryTypeName: String {
    case std = "Standard Delivery"
    case onDemd = "On Demand Delivery"
}

enum ShippingMethod: Int {
    case standard = 1
    case onDemand = 2
    case combination = 3
    case storePickup = 4
}
