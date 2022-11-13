//
//  HomeView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @State private var showAlert = false
    @State private var presentSheet = false
    
    var body: some View {
        
        
        VStack(spacing: 100) {
            
            userProfileRow
//            NavigationView{
//                Button("Пользовательское соглашение"){
//                    presentSheet = true
//                }.buttonStyle(.borderedProminent)
//            }.sheet(isPresented: $presentSheet){
//                AgreementwebPage()
//            }
            Button("logout") {
                showAlert = true
            }.buttonStyle(.bordered).alert("Вы уверены, что хотите выйти?", isPresented: $showAlert){
                Button("Выйти", role: .destructive){
                    UserManager.share.logOut()
                }
                Button("Отменить", role: .cancel){
                    showAlert = false
                }
            }
            Spacer()
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView{
    private var userProfileRow: some View{
        HStack{
            
            CustomLazyImage(strUrl: "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg")
                .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50, alignment: .leading)
                .clipShape(Circle())
            Text((homeVM.currentUser?.name ?? "") + "\(homeVM.currentUser?.surname ?? "")")
            Spacer()
        }
        .padding(.horizontal)
    }
}



