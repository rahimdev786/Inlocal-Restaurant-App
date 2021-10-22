//
//  CommentAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

typealias CommentListCompletion = (_ successResponse: CommentListResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

typealias AddCommentCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class CommentAPIDataManager: APIDataManager {

    init() {
    }
    
    // Data fetch service methods goes here
    func commentListCall(
                    skip: Int,
                    limit: Int,
                    postId: Int,
                    completion: @escaping CommentListCompletion) {
           let params = [
                "limit": limit,
                "skip": skip,
                "post_id": postId
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.commentList,
                       withParameters: params,
                       completion: completion)
    }
    
    func addCommentCall(
                    postId: Int,
                    message: String,
                    completion: @escaping AddCommentCompletion) {
           let params = [
                "post_id": postId,
                "message": message,
                "comment_user_type": "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.addCommnet,
                       withParameters: params,
                       completion: completion)
    }
}
