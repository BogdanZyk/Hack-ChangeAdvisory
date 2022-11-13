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
    
    
    static let promotions = [CompanyPromotion(title: "Alibaba", sector: "Потребительский", price: 71.4, value: 12.15),
                             CompanyPromotion(title: "Apple", sector: "IT", price: 148.45, value: 4.45),
                             CompanyPromotion(title: "Tesla motors", sector: "Потребительский", price: 195.1, value: 35.6),
                             CompanyPromotion(title: "NVIDIA", sector: "IT", price: 162.4, value: 3.5)]
}



