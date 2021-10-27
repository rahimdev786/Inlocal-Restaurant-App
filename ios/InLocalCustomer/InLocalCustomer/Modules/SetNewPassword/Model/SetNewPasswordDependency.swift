//
//  SetNewPasswordDependency.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import ObjectMapper

struct SetNewPasswordDependency {
    var userId: Int?
}

struct SetNewPasswordRequest {
    var newPassword: String?
    var conformPassword: String?
}
