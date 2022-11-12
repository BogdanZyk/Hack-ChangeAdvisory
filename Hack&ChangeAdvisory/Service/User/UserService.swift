//
//  UserService.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine


protocol UserServiceProtocol{
    
    func logIn(_ auth: UserAuth) -> AnyPublisher<UserResponse, Error>
    func getCurrentUser()-> AnyPublisher<User, Error>
    func getUserForId(_ id: Int) -> AnyPublisher<User, Error>
    func verifyJWT() -> AnyPublisher<VerifyResponse, Error>
    
}

final class UserService: UserServiceProtocol {
    
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
    
    func getCurrentUser() -> AnyPublisher<User, Error>{
        let endpoint = Endpoint.currentUser()
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        return networkManager.get(type: User.self, urlRequest: request)
    }
    
    func getUserForId(_ id: Int) -> AnyPublisher<User, Error>{
        let endpoint = Endpoint.userForId(id: id)
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        return networkManager.get(type: User.self, urlRequest: request)
    }
    
    func verifyJWT() -> AnyPublisher<VerifyResponse, Error>{
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let postData = try? JSONEncoder().encode(VerifyRequest(jwt: token)) else {
            return Fail(error: NetworkingError.unknow).eraseToAnyPublisher()
        }
        let endpoint = Endpoint.verifyJWT
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Endpoint.defaultHeaders
        request.httpBody = postData
        return networkManager.get(type: VerifyResponse.self, urlRequest: request)
    }
}



