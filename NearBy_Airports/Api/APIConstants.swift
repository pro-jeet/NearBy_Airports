//
//  APIConstants.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import Foundation
import UIKit

internal struct APIConstants {
    static let basePath = "https://gist.githubusercontent.com/"
    static let tdreyNo = "tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
    static let message = "message"
    
}

enum Keys : String {
    case none
    static let tdreyNo: [Keys] = []
}

enum ParamKeys: String {
    case none
    
}

enum ResponseKeys : String {
    case resul = "Result"
    case DinInfo = "DinInfo"
}

enum Validate : Int {
    case none
    case success = 200
    case notFound = 404
    case failure = 400
    
    case sessionExpire = 101
    case invalidAccessToken = 2
    case fbLogin = 3
    
    func map(response message : String?) -> String? {
        switch self {
        case .success, .none:
            return message
        case .failure :
            return message
        default:
            return nil
        }
    }
}

enum Response {
    case success(Any?)
    case failure(Any?)
}

typealias OptionalDictionary = [String : AnyObject]?
typealias NonOptionalDictionary = [String : AnyObject]
typealias Completion = (Response) -> ()

infix operator =>
infix operator =|
infix operator =<
infix operator =<<
infix operator =||
infix operator =^^
infix operator =^
infix operator =^|
prefix operator /


func =>(key : ParamKeys, json : OptionalDictionary) -> String? {
    if let result = json?[key.rawValue] as? String{
        return result
    }
    return nil
}

func =<(key : ParamKeys, json : OptionalDictionary) -> OptionalDictionary {
    if let result = json?[key.rawValue] as? [String:AnyObject]{
        return result
    }
    return nil
}


func =|(key : ParamKeys, json : OptionalDictionary) -> [AnyObject]? {
    if let result = json?[key.rawValue] as? [AnyObject]{
        return result
    }
    return nil
}

func =||(key : ParamKeys, json : OptionalDictionary) -> Int? {
    if let result = json?[key.rawValue] as? Int{
        return result
    }
    return nil
}

func =^|(key : ParamKeys, json : OptionalDictionary) -> Bool? {
    if let result = json?[key.rawValue] as? Bool{
        return result
    }
    return nil
    
}

func =^(key : ParamKeys, json : OptionalDictionary) -> Float? {
    if let result = json?[key.rawValue] as? Float{
        return result
    }
    return nil
}

func =^^(key : ParamKeys, json : OptionalDictionary) -> Double? {
    if let result = json?[key.rawValue] as? Double{
        return result
    }
    return nil
}

protocol OptionalType { init() }

//MARK:- EXTENSIONS
extension String: OptionalType {}
extension Int: OptionalType {}
extension Double: OptionalType {}
extension Bool: OptionalType {}
extension Float: OptionalType {}
extension CGFloat: OptionalType {}
extension CGRect: OptionalType {}
extension CGPoint: OptionalType {}
extension UIImage: OptionalType {}
extension IndexPath: OptionalType {}
extension Array: OptionalType {}
extension Dictionary: OptionalType {}
extension UInt: OptionalType {}


//unwrapping values
prefix func /<T: OptionalType>( value: T?) -> T {
    guard let validValue = value else { return T() }
    return validValue
}

enum Storyboards : String {
    case main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(_ controller: T.Type) -> T {
        let storyId = (controller as UIViewController.Type).storyboardId
        return instance.instantiateViewController(withIdentifier: storyId) as! T
    }
}

extension UIViewController {
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiateFrom(storyboard: Storyboards) -> Self {
        return storyboard.viewController(self)
    }
}



