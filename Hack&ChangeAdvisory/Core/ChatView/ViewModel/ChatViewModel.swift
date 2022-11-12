//
//  ChatViewModel.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject{
    
    let userManager = UserManager.share
    @Published var chatText: String = ""
    @Published var messageReceive: Int = 0
    @Published var chatMessages = [Message]()
    
    public var isActiveSendButton: Bool{
       return !chatText.isEmpty
    }
    
}
