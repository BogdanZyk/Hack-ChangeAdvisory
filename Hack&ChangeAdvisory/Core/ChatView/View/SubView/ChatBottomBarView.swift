//
//  ChatBottomBarView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 13.11.2022.
//

import SwiftUI

struct ChatBottomBarView: View {
    @Binding var showImageComfirmDialog: Bool
    @EnvironmentObject var chatVM: ChatViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Divider()
            imageViewForChatBottomBar
            HStack(spacing: 15) {
                
                HStack{
                    TextField(text: $chatVM.chatText) {
                        Text("Сообщение")
                    }
                    Button {
                        showImageComfirmDialog.toggle()
                    } label: {
                        Image(systemName: "paperclip")
                            .foregroundColor(.foreground2)
                            .font(.system(size: 25, weight: .medium))
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color.bg, in: RoundedRectangle(cornerRadius: 8))
                Button {
                    chatVM.sendMessage()
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.title3)
                        .padding(15)
                        .background(Color.bg, in: Circle())
                }
                .disabled(!chatVM.isActiveSendButton)
            }
            .padding(.horizontal, 15)
        }
        .padding(.bottom, 10)
        .background(Color.white)
        .background(.regularMaterial)
    }
}

struct ChatBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBottomBarView(showImageComfirmDialog: .constant(false))
            .environmentObject(ChatViewModel())
    }
}



// MARK: Image view for bottom bar

extension ChatBottomBarView{
    private var imageViewForChatBottomBar: some View{
        Group{
            if let uiImage = chatVM.imageData?.first?.image{
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 20)
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation(.easeInOut(duration: 0.15)) {
                    chatVM.deleteImage()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.callout)
                    .padding(5)
            }
        }
    }
}
