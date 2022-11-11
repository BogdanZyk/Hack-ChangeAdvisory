//
//  Endpoint.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

/// API specific Endpoint extension
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "hack.invest-open.ru"
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    static let defaultHeaders = [
        "Content-Type": "application/json"
    ]
    
    static func buildHeaders(key: String, value: String) -> [String: String] {
        var headers = defaultHeaders
        headers[key] = value
        return headers
    }
}

/// API endpoints
extension Endpoint {
   
    
   
    static func user(id: Int) -> Self {
        return Endpoint(path: "/user/info",
                        queryItems: [URLQueryItem(name: "userId", value: "\(id)")])
    }
    
    static var auth:  Self{
        return Endpoint(path: "/auth")
    }
}
