//
//  Message.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation

struct Message: Codable, Identifiable{
    
    var id: String {messageId}
    
    let messageId: String
    var text: String?
    var data: String?
    let messageType: MessageType
    var mediaUrl: String?
    let sender: Int
    let recipient: Int
    let dialogId: Int
    let timestamp: Int
    
    var messageDate: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        let date = Date(timeIntervalSinceNow: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
    
  
}

enum MessageType: String, Codable{
    case text = "TEXT"
    case widget = "WIDGET"
    case media = "MEDIA"
}



struct MessageRequest: Codable{
    let messageId: String
    let text: String
    let messageType: MessageType
    var data: String?
    var mediaUrl: String?
}


struct DialogIdResponse: Codable{
    var dialogId: Int
}
