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
    
    var webSocketUrl: URL{
        var components = URLComponents()
        components.scheme = "wss"
        components.host = "hack.invest-open.ru"
        components.path = "/chat"
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
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
    
    
    static func buildHeaders() -> [String: String] {
        var headers = defaultHeaders
        headers["Authorization"] = "Bearer \(UserDefaults.standard.string(forKey: "JWT") ?? "")"
        return headers
    }
}

/// API endpoints
extension Endpoint {
    
    
    static var sendMessage: Self{
        return Endpoint(path: "/message/send")
    }
    
    static func dealogHistory(dialogId: Int, timestamp: Int, older: String, limit: Int) -> Self{
        return Endpoint(path: "/chat/history",
                        queryItems: [URLQueryItem(name: "timestamp", value: "\(timestamp)"),
                                     URLQueryItem(name: "older", value: "\(older)"),
                                     URLQueryItem(name: "limit", value: "\(limit)"),
                                     URLQueryItem(name: "dialogId", value: "\(dialogId)")])
    }
    
    static var dialog: Self{
        return Endpoint(path: "/chat/dialog")
    }
    
    static func currentUser() -> Self {
        return Endpoint(path: "/user/info")
    }
    
    static func userForId(id: Int) -> Self {
        return Endpoint(path: "/user/info",
                        queryItems: [URLQueryItem(name: "userId", value: "\(id)")])
    }
    
    static var auth:  Self{
        return Endpoint(path: "/auth")
    }
    
    static var verifyJWT: Self{
        return Endpoint(path: "/jwt/verify")
    }
}
