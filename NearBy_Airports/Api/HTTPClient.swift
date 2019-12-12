//
//  HTTPClient.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit

typealias HttpClientSuccess = (Any? , Int) -> ()
typealias HttpClientFailure = (String) -> ()
//let url = /url1.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

var googleRestaurantUrl = ""

class HTTPClient {
    
    func convertDictionaryToString (dic : [String:AnyObject]) -> String
    {
        do{
            let data: NSData? = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData?
            
            var jsonStr: String?
            if data != nil {
                
                jsonStr = String(data: data! as Data, encoding: String.Encoding.utf8)
                return jsonStr!
            }
        }catch{
        }
        return ""
    }
    
    func postRequest(withApi api : Router  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure){
        DispatchQueue.main.async {UIApplication.shared.isNetworkActivityIndicatorVisible = true}
        requestWith(api: api, success: success, failure: failure)
    }
    
    func requestWith (api : Router,success: @escaping HttpClientSuccess , failure : @escaping HttpClientFailure){
        var fullPath = ""
        guard let params = api.parameters else{return}
        fullPath = api.baseURL + api.route
        
        let urlStr = fullPath
        let url = NSURL(string: urlStr)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = api.method.rawValue
        for (key,value) in api.header{
            request.setValue(value, forHTTPHeaderField:key)
        }
        if api.method != .get {
            let bodyStr = convertDictionaryToString(dic: params)
            let bodyData = bodyStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
            request.httpBody = bodyData
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {UIApplication.shared.isNetworkActivityIndicatorVisible = false}
            if(error==nil) {
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse {
                        success(data , httpResponse.statusCode)
                    }else{
                        failure("Somthing went wronge, not able to get status code")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    failure(/error?.localizedDescription)
                }
            }
        });
        task.resume()
    }
}


func isConnectedToNetwork() -> Bool {
    guard let reachability = Reachability()?.connection else { return false }
    return reachability == .none ? false : true
}
