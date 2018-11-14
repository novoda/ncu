//
//  NetworkingAPI.swift
//  NCU
//
//  Created by Simon Rowlands on 14/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

enum APIEndpoint: String {
    case baseURL = "https://api.hibob.com/v1"
    
    case people = "/people"
    
    func urlString() -> String {
        return APIEndpoint.baseURL.rawValue + self.rawValue
    }
}
