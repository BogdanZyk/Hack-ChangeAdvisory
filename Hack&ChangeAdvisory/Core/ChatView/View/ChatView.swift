//
//  ChatView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatVM = ChatViewModel()
    @State private var showImagePicker: Bool = false
    @State private var showDetailsImageView: Bool = false
    let scrollId = "BOTTOM"
    var body: some View {
        VStack(spacing: 0){
            ScrollViewReader{ scrollViewReader in
                if chatVM.showLoader{
                    laoderView
                }else{
                    ReversedScrollView{
                        
                        messagesSection
                        
                        emptyBottomAnhor
                    }
                    .onReceive(chatVM.$chatMessages) { _ in
                        withAnimation {
                            scrollViewReader.scrollTo(scrollId)
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom){
            chatBottomBar
        }
        .background(Color.bg)
//        .sheet(isPresented: $showImagePicker, onDismiss: nil) {
//            ImagePicker(imageData: $chatVM.imageData)
//        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                navigationBar
            }
        }
        .navigationBarBackButtonHidden(showDetailsImageView)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView()
                .preferredColorScheme(.light)
        }
    }
}

// MARK: Navigation bar contetn


extension ChatView{
    private var navigationBar: some View{
        Text("Messages")
    }
}

// MARK: Bottom bar section view
extension ChatView{

    private var chatBottomBar: some View{
        VStack(alignment: .leading, spacing: 20) {
            Divider()
            //imageViewForChatBottomBar
            HStack(spacing: 15) {
                Button {
                    showImagePicker.toggle()
                } label: {
                    Image(systemName: "paperclip")
                        .font(.system(size: 25, weight: .medium))
                }
                PrimaryTextField(label: "Сообщение", text: $chatVM.chatText)
                Button {
                    chatVM.sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                }
                .disabled(!chatVM.isActiveSendButton)
            }
            .padding(.horizontal, 15)
        }
        .padding(.bottom, 10)
        .background(Color.white)
        .background(.regularMaterial)
    }
    
    private var laoderView: some View{
        ProgressView().tint(.accentColor).scaleEffect(1.5)
            .allFrame()
    }
    
//    private var imageViewForChatBottomBar: some View{
//        Group{
//            if let image = chatVM.imageData?.image{
//                ZStack {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                    if chatVM.isLoading{
//                        Color.black.opacity(0.2)
//                        ProgressView()
//                    }
//                }
//                .frame(width: 100, height: 100)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .padding(.leading, 20)
//            }
//        }
//        .overlay(alignment: .topTrailing) {
//            Button {
//                withAnimation(.easeInOut(duration: 0.15)) {
//                    chatVM.deleteImage()
//                }
//            } label: {
//                Image(systemName: "xmark.circle.fill")
//                    .foregroundColor(.white)
//                    .font(.callout)
//                    .padding(5)
//            }
//        }
//    }
    
    private var emptyBottomAnhor: some View{
        Text("")
            .id(scrollId)
            .padding(-10)
    }
    

    
//
//    private func messageRowView(messages: Message) -> some View{
//        ChatBubble(direction: messages.fromId == currentUserId ? .right : .left) {
//            let isRecevied = messages.fromId == currentUserId
//            if let image = messages.image.imageURL, let imageURL = URL(string: image){
//                textAndImageMessageView(messages, isRecevied: isRecevied, imageURL: imageURL)
//                .onTapGesture {
//                    chatVM.selectedChatMessages = messages
//                    withAnimation {
//                        showDetailsImageView.toggle()
//                    }
//                }
//            }else{
//                textMessageView(messages, isRecevied: isRecevied)
//            }
//        }
//        .padding(.vertical, 4)
//        .onAppear{
//            if messages.id == chatVM.chatMessages.last?.id{
//                chatVM.viewLastMessage()
//            }
//        }
//    }
//
//    private func textMessageView(_ message: Message, isRecevied: Bool) -> some View{
//        let recivedColorBg: LinearGradient = LinearGradient(colors: [.messBlueLight, .messBlueDark], startPoint: .topTrailing, endPoint: .bottomLeading)
//        let messBg: LinearGradient = LinearGradient(colors: [.secondaryBlue], startPoint: .trailing, endPoint: .leading)
//        var bgColor: LinearGradient{
//            isRecevied ? recivedColorBg : messBg
//        }
//          return  HStack(alignment: .bottom, spacing: 5) {
//                Text(message.text)
//                  .font(.urbRegular(size: 14))
//                  .foregroundColor(isRecevied ? .white : .whiteOrGray)
//                Text(message.messageTime)
//                    .font(.urbRegular(size: 10))
//                    .foregroundColor(isRecevied ? .white : .whiteOrGray).opacity(0.8)
//            }
//            .padding(EdgeInsets.init(top: 10, leading: 15, bottom: 10, trailing: 15))
//            .background(bgColor)
//    }
    
//    private func textAndImageMessageView(_ message: Message, isRecevied: Bool, imageURL: URL) -> some View{
//        let recivedColorBg: LinearGradient = LinearGradient(colors: [.messBlueLight, .messBlueDark], startPoint: .topTrailing, endPoint: .bottomLeading)
//        let messBg: LinearGradient = LinearGradient(colors: [.secondaryBlue], startPoint: .trailing, endPoint: .leading)
//        var bgColor: LinearGradient{
//            isRecevied ? recivedColorBg : messBg
//        }
//        return VStack(alignment: .leading, spacing: 0){
//            ImageView(imageUrl: imageURL)
//                .frame(width: 220, height: 200)
//            if !message.text.isEmpty{
//                Text(message.text)
//                    .font(.urbRegular(size: 14))
//                    .foregroundColor(isRecevied ? .white : .whiteOrGray)
//                    .padding(EdgeInsets.init(top: 10, leading: 15, bottom: 10, trailing: 15))
//            }
//        }
//        .background(bgColor)
//    }
   
}


// MARK: Messages section

extension ChatView{
    private var messagesSection: some View{
        LazyVStack(spacing: 0) {
            ForEach(chatVM.chatMessages){ message in
               MessageView(message: message, isSender: false)
            }
            .padding(.vertical, 4)
        }
        .padding(.horizontal, 10)
    }
}
