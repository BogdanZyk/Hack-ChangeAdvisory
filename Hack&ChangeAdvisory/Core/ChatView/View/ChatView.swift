//
//  ChatView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatVM = ChatViewModel()
    @State private var pickerType: ImagePickerType = .photoLib
    @State private var showImagePicker: Bool = false
    @State private var showImageComfirmDialog: Bool = false
    @State private var showDetailsImageView: Bool = false
    @State private var showDownScrollButton: Bool = false
    let scrollId = "BOTTOM"
    var body: some View {
        VStack(spacing: 0){
            navigationBar
            ScrollViewReader{ scrollViewReader in
                if chatVM.showLoader{
                    laoderView
                }else{
                    ReversedScrollView{
                        
                        messagesSection
                        
                        emptyBottomAnhor
                    }
                    .overlay(alignment: .bottomTrailing) {
                        downScrollButton(scrollViewProxy: scrollViewReader)
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
            ChatBottomBarView(showImageComfirmDialog: $showImageComfirmDialog)
        }
        .environmentObject(chatVM)
        .background(Color.bg)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(showDetailsImageView)
        .imagePicker(pickerType: pickerType, show: $showImagePicker, imagesData: $chatVM.imageData, onDismiss: {})
        .confirmationDialog("", isPresented: $showImageComfirmDialog) {
            comfirmContent
        }
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
        ChatNavigationBarView()
    }
}

// MARK: Bottom bar section view
extension ChatView{

 
    
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
                MessageView(message: message, isSender: UserManager.share.currentUser?.userId == message.sender)
                    .onAppear{
                        if message.id == chatVM.chatMessages.last?.id{
                            showDownScrollButton = false
                        }
                    }
                    .onDisappear{
                        if message.id == chatVM.chatMessages.last?.id{
                            showDownScrollButton = true
                        }
                    }
            }
            .padding(.vertical, 4)
        }
        .padding(.horizontal, 10)
    }
    
    
    private func downScrollButton(scrollViewProxy: ScrollViewProxy) -> some View{
        Group{
            if showDownScrollButton{
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(10)
                    .background(Color.foreground3)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        withAnimation {
                            scrollViewProxy.scrollTo(scrollId)
                        }
                    }
            }
        }
    }
}





// MARK: Comfirm

extension ChatView{
    private var comfirmContent: some View{
        Group{
            Button("Сделать фото") {
                pickerType = .camera
                showImagePicker = true
            }
            Button("Выбрать из галереи") {
                pickerType = .photoLib
                showImagePicker = true
            }
        }
    }
}
