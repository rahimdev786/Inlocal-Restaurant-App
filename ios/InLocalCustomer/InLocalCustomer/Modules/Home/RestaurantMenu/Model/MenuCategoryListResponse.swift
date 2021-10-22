//
//  MenuListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 20/10/21.
//

import ObjectMapper

struct MenuCategoryListResponse: Mappable, Codable {
    
    var categoryList: [MenuCategoryList]?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        categoryList <- map["cateListing"]
    }

}

struct MenuCategoryList: Mappable, Codable {
    
    var id: Int?
    var name: String?
    var active: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        active <- map["active"]
    }
}
