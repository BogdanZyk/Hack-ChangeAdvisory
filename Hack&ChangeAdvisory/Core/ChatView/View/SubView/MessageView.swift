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
        VStack(alignment: .leading, spacing: 10) {
            messageRowView
            if message.messageType == .widget{
                WidgetFinanceView(isSender: isSender)
                    .frame(height: getRect().height / 4)
            }
        }
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
                imageView
                if let text = message.text{
                    HStack(alignment: .bottom) {
                        Text(text)
                            .font(.system(size: 16))
                        if message.messageType == .media{
                            Spacer()
                        }
                        Text(message.messageDate ?? "")
                            .font(.system(size: 10))
                    }
                }
            }
            .padding(8)
            .padding(.horizontal, 5)
            .foregroundColor(isSender ? .white : .black)
            .background(isSender ? Color.accentColor : Color.accentBg)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: getRect().width / 1.4, alignment: isSender ? .trailing : .leading)
            .padding(.vertical, 2)
        }
        .frame(maxWidth: .infinity, alignment: isSender ? .trailing : .leading)
    }
    private var imageView: some View{
        Group{
            if let image = message.mediaUrl{
                CustomLazyImage(strUrl: image, resizingMode: .aspectFill, loadPriority: .high)
                .frame(height: 150)
                .cornerRadius(8)
                .padding(.init(top: -4, leading: -8, bottom: 5, trailing: -8))
            }
        }
    }
}

