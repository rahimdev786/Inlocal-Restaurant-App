//
//  CustomTransformations.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 27/09/21.
//

import ObjectMapper

struct CustomTransformations {
    
    // default Int to APIError
    static let apiErrorCodeTransformation = TransformOf<APIError, Int>(fromJSON: { (value: Int?) -> APIError? in
        // transform value from Int? to APIError?
        if let value = value {
            return APIError(rawValue: value)
        } else {
            return nil
        }
    }, toJSON: { (value: APIError?) -> Int? in
        // transform value from APIError? to Int?
        if let value = value {
            return value.rawValue
        } else {
            return nil
        }
    })

}
    

