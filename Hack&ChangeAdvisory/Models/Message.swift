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
        let date = timestamp.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.string(from: date)
    }
    
  
}

enum MessageType: String, Codable{
    case text = "TEXT"
    case widget = "WIDGET"
    case media = "MEDIA"
    
    func getType(image: String?) -> Self{
        if image != nil{
            return .media
        }else{
            return .text
        }
    }
}


struct MessageResponse: Codable{
    let messages: [Message]
}


struct MessageRequest: Codable{
    
    let message: Message
    
    struct Message: Codable{
        let dialogId: Int
        let text: String
        let messageType: String
        var data: String?
        var mediaUrl: String?
    }
}

struct SendMessageResponse: Codable{
    let messageId: String
}

struct DialogIdResponse: Codable{
    var dialogId: Int
}


struct SocketMessageModel: Codable{
    var messageData: Message
}


//{"messageData":{"messageId":"29eac78e-5b6b-4af0-807e-d9e0d3ccf8ea","text":"Test12","messageType":"TEXT","sender":100143,"recipient":100142,"dialogId":3,"timestamp":1668261720157}}
