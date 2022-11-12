//
//  ChatService.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine


protocol ChatServiceProtocol: AnyObject{
    
    func getDialogId() -> AnyPublisher<DialogIdResponse, Error>
    
    func getDialogHistoryForId(_ dialogId: Int) -> AnyPublisher<Message, Error>
    
    func sendMessage(_ params: MessageRequest) -> AnyPublisher<DialogIdResponse, Error>
    
}


final class ChatService: ChatServiceProtocol{
    
    let networkManager = NetworkController.share
    
    func getDialogId() -> AnyPublisher<DialogIdResponse, Error>{
        let endpoint = Endpoint.dialog
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        return networkManager.get(type: DialogIdResponse.self, urlRequest: request)
    }
    
    func getDialogHistoryForId(_ dialogId: Int) -> AnyPublisher<Message, Error>{
        let endpoint = Endpoint.dealogHistory(dialogId: dialogId, limit: 30)
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        return networkManager.get(type: Message.self, urlRequest: request)
    }
    
    func sendMessage(_ params: MessageRequest) -> AnyPublisher<DialogIdResponse, Error>{
        guard let messageData = try? JSONEncoder().encode(params) else {
           print("Error encode model")
            return Fail(error: NetworkingError.unknow).eraseToAnyPublisher()
        }
        let endpoint = Endpoint.sentMessage
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        request.httpBody = messageData
        return networkManager.get(type: DialogIdResponse.self, urlRequest: request)
    }
}



