//
//  NetworkManager.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

import Alamofire

class NetworkManager: NSObject {
    
    let baseURL = "http://appbirds.co/movies/API/"
    static let sharedInstance = NetworkManager()
    
    func makePostRequest(path : String, parameters:[String: Any], success:@escaping (_ apiResponse : [String : Any]?) -> (), failure:@escaping (_ error : Error?) -> ()) {
        let completeURL = baseURL + path
        
        print("Request URL : \(completeURL)")
        print("Request Params : \(parameters)")
        
        Alamofire.request(completeURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(let value):
                if let responseDictionary = value as? [String : Any] {
                    print(responseDictionary)
                    success(responseDictionary)
                } else {
                    failure(nil)
                }
                break
                
            case .failure(_):
                failure(response.result.error)
                break
            }
        }
    }
}
