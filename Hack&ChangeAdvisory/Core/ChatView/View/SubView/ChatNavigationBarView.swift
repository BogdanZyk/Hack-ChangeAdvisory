//
//  ChatNavigationBarView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 13.11.2022.
//

import SwiftUI

struct ChatNavigationBarView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    var body: some View {
        HStack(spacing: 15) {
            Group{
                if let userAvatar = chatVM.recipientUser?.avatar{
                    CustomLazyImage(strUrl: userAvatar)
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.foreground3)
                }
            }
            .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 2){
                Text(chatVM.recipientUser?.fullName ?? "Name")
                    .font(.system(size: 16, weight: .bold))
                Text(chatVM.chatMode == .client ? "Финансовый ассистент" : "Клиент валютного сектора")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.foreground2)
            }
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .imageScale(.medium)
            }
            Button {
                
            } label: {
                Image("kebab-menu")
                    .imageScale(.medium)
            }
        }
        .hCenter()
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}

struct ChatNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChatNavigationBarView()
            .environmentObject(ChatViewModel())
    }
}
