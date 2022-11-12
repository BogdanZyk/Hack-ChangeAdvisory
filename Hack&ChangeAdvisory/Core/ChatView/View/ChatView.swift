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
    
    private var emptyBottomAnhor: some View{
        Text("")
            .id(scrollId)
            .padding(-10)
    }
    
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
