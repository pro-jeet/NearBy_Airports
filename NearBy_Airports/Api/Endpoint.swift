//
//  EndPoint.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit


enum Endpoint{
    case tdreyNo()
}

extension Endpoint : Router {
    
    var header: [String : String] {
        switch self {
        default:
            return ["Content-Type":"application/json"]
        }
    }
    
    var indicator: Bool {
        switch self {
        default:
            return false
        }
    }
    
    func request(completion: @escaping Completion) {
        APIManager.shared.request(with: self, completion: completion)
    }
    
    var route : String  {
        switch self {
        case .tdreyNo : return APIConstants.tdreyNo
        }
    }
    
    var parameters: OptionalDictionary {
        return format()
    }
    
    func format() -> OptionalDictionary {
        switch self {
        case .tdreyNo():
            return Keys.tdreyNo.map(values: [])

        }
    }

    var method : HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var baseURL: String {
        switch self {
       default:
            return APIConstants.basePath
        }
    }
}
