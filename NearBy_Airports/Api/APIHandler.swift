//
//  EndPoint.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import Foundation

extension Endpoint {
    func handle(parameters : [AnyObject], data: Data) -> Any? {
        let jsonDecoder = JSONDecoder()
        do{
            switch self {
            case .tdreyNo:
                let data = try convertJsonToData(json: parameters)
                return try jsonDecoder.decode([CityModel].self, from: data)
            }
        }catch{
            debugPrint(error)
            debugPrint("unable to make model")
            return nil
        }
    }

    func convertJsonToData(json: Any?) throws -> Data {
        guard let json = json else{throw ErrorEnum.err("Json not in correct format")}
        return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
}

enum ErrorEnum: Error {
    case err(String)
}
