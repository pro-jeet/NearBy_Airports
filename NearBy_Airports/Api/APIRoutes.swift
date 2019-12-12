//
//  Router.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import Foundation
import UIKit


protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : HTTPMethod { get }
    var indicator : Bool { get }
    var header : [String: String] { get }
    func handle(parameters : [AnyObject], data: Data) -> Any?
    func request(completion : @escaping Completion )
}

extension Sequence where Iterator.Element == Keys {
    func map(values: [Any?]) -> [String : AnyObject]? {
        var params = [String : AnyObject]()
        for (index,element) in zip(self,values) {
            params[index.rawValue] = element as AnyObject
        }
        return params
        
    }
}

enum HTTPMethod: String{
    case get
    case post
}
