//
//  HomeView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    var body: some View {
        VStack {
            userProfileRow
            Button("logout") {
                UserManager.share.logOut()
            }
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
            Text((homeVM.currentUser?.name ?? "") + "\(homeVM.currentUser?.surname ?? "")")
        }
    }
}



