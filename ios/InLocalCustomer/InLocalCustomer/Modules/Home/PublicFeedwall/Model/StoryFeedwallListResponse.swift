//
//  StoryFeedwallListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 18/10/21.
//

import ObjectMapper

struct StoryFeedwallListResponse: Mappable, Codable  {
    
    var myFeedWallStories: [MyFeedWallStories]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        myFeedWallStories <- map["MyFeedWallStories"]
    }
}

struct MyFeedWallStories: Mappable, Codable {
    
    var storyId: Int?
    var storyUserType: String?
    var storyImage: String?
    var name: String?
    var profileImage: String?
    var follow: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        storyId <- map["story_id"]
        storyUserType <- map["story_user_type"]
        storyImage <- map["story_image"]
        name <- map["name"]
        profileImage <- map["profile_image"]
        follow <- map["follow"]
    }
}
