//
//  UploadStoryAPIDataManager.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 12/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

typealias CreateStroyCompletion = (_ successResponse: EmptyResponse?, _ errorResponse: APIError?, _ error: Error?) -> Void

class UploadStoryAPIDataManager: APIDataManager {
    
    init() {
    }
    
    // Data fetch service methods goes here
    func createStoryCall(
                    image: UIImage,
                    completion: @escaping CreateStroyCompletion) {
           let params = [
               "story_user_type": "Customer"
               ] as [String : Any]
        
           print(params)
           makeAPICall(to: HomeEndpoints.createStory,
                       withParameters: params,
                       completion: completion)
        
            createStoryCall(to: HomeEndpoints.createStory, withImage: image, withParameters: params, completion: completion)
       }
}
