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
    
    func getDialogHistoryForId(_ dialogId: Int) -> AnyPublisher<MessageResponse, Error>
    
    func sendMessage(_ params: MessageRequest) -> AnyPublisher<SendMessageResponse, Error>
 
    func updateDataWidget(_ params: UpdateDataWidgetRequest) -> AnyPublisher<Data, Error>
}


final class ChatService: ChatServiceProtocol{
    
    let networkManager = NetworkController.share
    
    func getDialogId() -> AnyPublisher<DialogIdResponse, Error>{
        let endpoint = Endpoint.dialog
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        return networkManager.get(type: DialogIdResponse.self, urlRequest: request)
    }
    
    func getDialogHistoryForId(_ dialogId: Int) -> AnyPublisher<MessageResponse, Error>{
        print(Date.currentTimeStamp)
        let endpoint = Endpoint.dealogHistory(dialogId: dialogId, timestamp: Date().unixTimestamp, older: "TRUE", limit: 30)
        var request = URLRequest(url: endpoint.url)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        return networkManager.get(type: MessageResponse.self, urlRequest: request)
    }
    
    func sendMessage(_ params: MessageRequest) -> AnyPublisher<SendMessageResponse, Error>{
        guard let postData = try? JSONEncoder().encode(params) else {
           print("Error encode model")
            return Fail(error: NetworkingError.unknow).eraseToAnyPublisher()
        }
        let endpoint = Endpoint.sendMessage
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        request.httpBody = postData
        return networkManager.get(type: SendMessageResponse.self, urlRequest: request)
    }
    
    func updateDataWidget(_ params: UpdateDataWidgetRequest) -> AnyPublisher<Data, Error>{
        guard let postData = try? JSONEncoder().encode(params) else {
           print("Error encode model")
            return Fail(error: NetworkingError.unknow).eraseToAnyPublisher()
        }
        let endpoint = Endpoint.udateDataWidget
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        request.httpBody = postData
        return networkManager.update(urlRequest: request)
    }
}




