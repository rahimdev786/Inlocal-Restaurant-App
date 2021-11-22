//
//  CommentListResponse.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 21/10/21.
//

import ObjectMapper

struct CommentListResponse: Mappable, Codable {
    var commentList : CommentList?
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        commentList <- map["CommentList"]
    }
}

struct CommentList: Mappable, Codable {
    
    var postId : Int?
    var restaurantId : Int?
    var message : String?
    var postImage : String?
    var likeCounter : Int?
    var userPostBy : Int?
    var postUserType : String?
    var comments : [Comments]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        postId <- map["post_id"]
        restaurantId <- map["restaurant_id"]
        message <- map["message"]
        postImage <- map["post_image"]
        likeCounter <- map["like_counter"]
        userPostBy <- map["user_post_by"]
        postUserType <- map["post_user_type"]
        comments <- map["comments"]
    }
}

struct Comments : Mappable, Codable {
    
    var id : Int?
    var message : String?
    var userCommentBy : Int?
    var commentUserType : String?
    var name : String?
    var userProfileImage : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        message <- map["message"]
        userCommentBy <- map["user_comment_by"]
        commentUserType <- map["comment_user_type"]
        name <- map["name"]
        userProfileImage <- map["user_profile_image"]
    }
}

