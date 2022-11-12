//
//  ChatViewModel.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine
import SwiftUI


final class ChatViewModel: ObservableObject{
    
    let userService: UserServiceProtocol
    let chatService: ChatServiceProtocol
    let userManager = UserManager.share
    let webSoketStream: WebSocketStream
    
    @Published var chatText: String = ""
    @Published var chatMessages = [Message]()
    @Published var showLoader: Bool = false
    @Published var imageData: [UIImageData]?
    @Published var recipientUser: User?
    @Published var chatMode: ChatViewMod = .client
    
    private var dialogId: Int?
    private var cancellable = Set<AnyCancellable>()
   
    
    init(chatService: ChatServiceProtocol = ChatService(),
         userService: UserServiceProtocol = UserService()){
        
        self.chatService = chatService
        self.userService = userService
        self.chatMode = userManager.userRole == .operator ? .operator : .client
        
        
        let endpoint = Endpoint.init(path: "")
        var request = URLRequest(url: endpoint.webSocketUrl)
        request.allHTTPHeaderFields = Endpoint.buildHeaders()
        self.webSoketStream = WebSocketStream(request: request)
        
        self.getDialogIdAndFetchDialogHistory()
        self.webSocketObserver()
    }
    
}


// MARK: Websocket api

extension ChatViewModel{
    func webSocketObserver(){
        Task {
            do {
                for try await message in webSoketStream {
                    switch message{
                    case .string(let message):
                        guard let data = message.data(using: .utf8) else {return}
                        guard let serverData = try? SocketMessageModel.decode(from: data) else {return}
                        DispatchQueue.main.async {
                            self.chatMessages.append(serverData.messageData)
                        }
                    default:
                        break
                    }
                }
            } catch {
                debugPrint("Oops something didn't go right")
            }
        }
    }
}


// MARK: API
extension ChatViewModel{
    
    func getDialogIdAndFetchDialogHistory(){
        self.showLoader = true
        chatService.getDialogId()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    self.showLoader = false
                case .failure(let error):
                    self.showLoader = false
                    print(error.localizedDescription)
                }
            } receiveValue: {response in
                print("DIALOG ID", response.dialogId)
                self.dialogId = response.dialogId
                self.fetchDialogHistory(for: response.dialogId)
            }
            .store(in: &cancellable)
    }
    
    func fetchDialogHistory(for id: Int){
        chatService.getDialogHistoryForId(id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.chatMessages = response.messages
                if self.recipientUser == nil{
                    self.fethchRecipientUser()
                }
            }
            .store(in: &cancellable)
    }
    
    func sendMessage(){
        guard let dialogId = dialogId else {return}
        ImageUploader.uploadImage(withImage: imageData?.first?.image) {[weak self] mediaUrl in
            guard let self = self else {return}
            let request = MessageRequest(message: .init(dialogId: dialogId, text: self.chatText, messageType: MessageType.text.getType(image: mediaUrl).rawValue, mediaUrl: mediaUrl))
            print(mediaUrl)
            self.sendMessageWithRequest(request: request)
        }
    }
    
    private func sendMessageWithRequest(request: MessageRequest){
        chatService.sendMessage(request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    print("SEND MESSAGE")
                    self.chatText = ""
                    self.deleteImage()
                case .failure(let error):
                    print("SendMessage Error", error.localizedDescription)
                }
            } receiveValue: { data in
                print(data.messageId)
            }
            .store(in: &cancellable)
    }
    
    private func fethchRecipientUser(){
        guard let userId = getRecipientId() else {return}
        userService.getUserForId(userId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkController.share.handlingCompletion(completion: completion)
            } receiveValue: { recipient in
                print(recipient)
                print(userId)
                self.recipientUser = recipient
            }
            .store(in: &cancellable)
    }
}

// MARK: Helpers
extension ChatViewModel{
    
    public var isActiveSendButton: Bool{
        !chatText.isEmpty
    }
    
    public func deleteImage(){
        imageData?.removeAll()
    }
    
    func getRecipientId() -> Int?{
        chatMessages.first(where: {$0.recipient != userManager.currentUser?.userId})?.recipient
    }
    
    
}

// MARK: Chat mode
extension ChatViewModel{
    
    enum ChatViewMod: Int {
        
        case `operator`, client
        
        
        var navigatinTitle: String{
            switch self{
            case .operator: return "Чат поддержки с клиентом"
            case .client: return "Центр заботы клиентах"
            }
        }
        
        
       // var subTitle
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self? {
        do {
            let newdata = try decoder.decode(Self.self, from: data)
            return newdata
        } catch {
            print("decodable model error", error.localizedDescription)
            return nil
        }
    }
}
