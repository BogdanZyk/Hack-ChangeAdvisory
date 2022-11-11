//
//  UserServices.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine


protocol UserServicesProtocol{
    func logIn(_ auth: UserAuth) -> AnyPublisher<UserResponse, Error>
}

final class UserServices: UserServicesProtocol {
    
    let networkManager = NetworkController.share
    
    
    func logIn(_ auth: UserAuth) -> AnyPublisher<UserResponse, Error>{
        guard let authData = try? JSONEncoder().encode(auth) else {
           print("Error encode model")
            return Fail(error: NetworkingError.unknow).eraseToAnyPublisher()
        }
        let endpoint = Endpoint.auth
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Endpoint.defaultHeaders
        request.httpBody = authData as Data
        return networkManager.get(type: UserResponse.self, urlRequest: request)
    }
    
}


struct UserResponse: Codable{
    var userId: Int
    var login: String
    var role: String
    var jwtToken: String
}

struct UserAuth: Codable{
    var login: String
    var password: String
}



