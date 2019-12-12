//
//  APIManager.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//


import Foundation
import UIKit



class APIManager{
    
    static let shared = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router  , completion : @escaping Completion)  {
        if !isConnectedToNetwork(){
            //no internet
            completion(Response.failure(""))
            return
        }
        let loading = LoadingIndicator(frames: UIScreen.main.bounds)
        if api.indicator {
            UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(loading)
        }
        httpClient.postRequest(withApi: api, success: { (data , statusCode) in
            loading.removeFromSuperview()
            
            debugPrint(/api.baseURL + /api.route)
            debugPrint(api.header)
            debugPrint(/api.parameters)
            
            guard let response = data as? Data else {
                completion(Response.failure(.none))
                return
            }
            var json: [AnyObject]!
            
            do {
                guard let js = try JSONSerialization.jsonObject(with: response, options: []) as? [AnyObject] else{
                    completion(Response.failure(.none))
                    return
                }
                json = js
                debugPrint(json)
            } catch {
                completion(Response.failure(.none))
                let str = String(data: response, encoding: String.Encoding.utf8)
                debugPrint(/str)
                return
            }
            
            var responseType =  Validate.failure
            if statusCode == 200 {
                responseType = Validate.success
            }
            
            if responseType == Validate.success{
                let object : Any?
                object = api.handle( parameters: json, data: response )
                completion( Response.success(object) )
                return
            }else{
                completion(Response.failure(json))
            }
        }, failure: { (message) in
            loading.removeFromSuperview()
            completion(Response.failure(message))
        })
    }
}
