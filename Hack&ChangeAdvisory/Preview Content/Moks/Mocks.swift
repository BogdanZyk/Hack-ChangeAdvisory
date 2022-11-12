//
//  Mocks.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation

class Mocks{
    
    
    static let messages = [Message(messageId: UUID().uuidString, text: "Привет, оператор!", data: nil, messageType: .text, mediaUrl: nil, sender: 100500, recipient: 100501, dialogId: 1, timestamp: 1668153956319),
                           Message(messageId: UUID().uuidString, text: "Привет, клиент!", data: nil, messageType: .text, mediaUrl: nil, sender: 100500, recipient: 100501, dialogId: 1, timestamp: 1668153956319)]
}



