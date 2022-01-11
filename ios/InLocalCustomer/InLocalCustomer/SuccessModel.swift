//
//  SuccessModel.swift
//  SoLooke
//
//  Created by Sanket Bhamare on 06/12/21.
//

import Foundation
import ObjectMapper


// MARK: - SuccessModel
struct SuccessModel: Mappable,Codable {
    
    var success: Bool?
    var code: Int?
    var message: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["success"]
        code <- map["code"]
        message <- map["message"]
    }
    
    
}
