//
//  NetworkController.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine

final class NetworkController: NetworkControllerProtocol {

    static let share = NetworkController()
    
    private init(){}
    
    func get<T: Decodable>(type: T.Type,
                           urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { try self.handleURLResponse(output: $0, url: urlRequest.url!)}
            .retry(2)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}


extension NetworkController{
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
                  throw NetworkingError.badURLResponse(url: url)
              }
        return output.data
    }
    
    func handlingCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

enum NetworkingError: LocalizedError{
    case badURLResponse(url: URL)
    case unknow
    
    var errorDescription: String?{
        switch self {
        case .badURLResponse(let url):
            return "Bad response from URL \(url)"
        case .unknow:
            return "Unknow error occured"
        }
    }
}
