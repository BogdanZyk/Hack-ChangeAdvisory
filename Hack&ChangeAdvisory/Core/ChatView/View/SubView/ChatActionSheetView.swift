//
//  ChatActionSheetView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 13.11.2022.
//

import SwiftUI

struct ChatActionSheetView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Text("Оценить работу ассистента")
                    Text("Отключить уведомления")
                }
                .font(.system(size: 18))
            }
            .navigationTitle("Настройки чата")
        }
    }
}

struct ChatActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ChatActionSheetView()
            .environmentObject(ChatViewModel())
    }
}
