//
//  ChatViewModel.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject{
    
    let chatService: ChatServiceProtocol
    let userManager = UserManager.share
    
    @Published var chatText: String = ""
    @Published var messageReceive: Int = 0
    @Published var chatMessages = [Message]()
    
    var dialogId: Int?
    private var cancellable = Set<AnyCancellable>()
   
    
    init(chatService: ChatServiceProtocol = ChatService()){
        self.chatService = chatService
        getDialogIdAndFetchDialogHistory()
    }
    
    
    
}

// MARK: API
extension ChatViewModel{
    
    func getDialogIdAndFetchDialogHistory(){
        chatService.getDialogId()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                    
                case .finished:
                    break
                case .failure(let error):
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
                print(response.messages)
            }
            .store(in: &cancellable)
    }
    
    func sendMessage(){
        guard let dialogId = dialogId else {return}
        let request = MessageRequest(message: .init(dialogId: dialogId, text: chatText, messageType: MessageType.text.rawValue))
        chatService.sendMessage(request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                    
                case .finished:
                    print("SEND MESSAGE")
                    self.chatText = ""
                case .failure(let error):
                    print("SendMessage Error", error.localizedDescription)
                }
            } receiveValue: { data in
                print(data.messageId)
            }
            .store(in: &cancellable)
    }
}

// MARK: Helpers
extension ChatViewModel{
    
    public var isActiveSendButton: Bool{
       return !chatText.isEmpty
    }
}
