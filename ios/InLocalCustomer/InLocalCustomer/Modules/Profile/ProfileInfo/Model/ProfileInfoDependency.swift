//
//  ProfileInfoDependency.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit
struct ProfileInfoDependency {
}

struct AccountDetails {
    var title: String?
    var image: UIImage?
    var type: DetailType?
}

enum DetailType {
    case orders
    case bookings
    case savedPosts
    case addressBook
    case changePassword
    case notificationSettings
}
