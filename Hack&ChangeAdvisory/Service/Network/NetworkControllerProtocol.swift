//
//  NetworkControllerProtocol.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine

protocol NetworkControllerProtocol: AnyObject {
    
    typealias Headers = [String: Any]
    typealias Params = [String: Any]
    
    func get<T>(type: T.Type,
                urlRequest: URLRequest
    ) -> AnyPublisher<T, Error> where T: Decodable
}
