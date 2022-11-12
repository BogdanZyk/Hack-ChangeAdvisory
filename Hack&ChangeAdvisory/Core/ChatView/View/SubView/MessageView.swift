//
//  MessageView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    var isSender: Bool
    
    var body: some View {
        messageRowView
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            MessageView(message: Mocks.messages.first!, isSender: true)
            MessageView(message: Mocks.messages.first!, isSender: false)
        }
        .padding()
    }
}

extension MessageView{
    
    private var messageRowView: some View{
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                if let text = message.text{
                    Text(text)
                        .font(.system(size: 16))
//                    Text(message.messageDate ?? "")
//                        .font(.caption2)
//                        .hTrailing()
                }
            }
            .padding(10)
            .padding(.horizontal, 5)
            .foregroundColor(isSender ? .white : .black)
            .background(isSender ? Color.accentColor : Color.accentBg)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: getRect().width / 2, alignment: isSender ? .trailing : .leading)
            .padding(.vertical, 2)
        }
        .frame(maxWidth: .infinity, alignment: isSender ? .trailing : .leading)
    }
}

