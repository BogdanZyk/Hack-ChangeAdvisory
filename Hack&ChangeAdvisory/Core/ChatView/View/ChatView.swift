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
                .environmentObject(chatVM)
        }
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
        VStack(spacing: 5){
            Text(chatVM.chatMode.navigatinTitle)
                .font(.system(size: 18, weight: .bold))
            Group{
                if chatVM.chatMode == .client{
                    Text("Готовы ответить на ваши воросы\nпо будням с 10.00 до 19.00 по мск")
               }else{
                   Text("\(chatVM.recipientUser?.name ?? "")" + "\(chatVM.recipientUser?.surname ?? "")")
               }
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.foreground2)
        }
        .hCenter()
        .padding(.bottom, 10)
        .background(Color.white)
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
            }
            .padding(.vertical, 4)
        }
        .padding(.horizontal, 10)
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
