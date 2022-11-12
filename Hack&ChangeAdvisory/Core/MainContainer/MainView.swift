//
//  MainView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: Tab = .home
    var body: some View {
        TabView(selection: $currentTab) {
            HomeView()
            .tabItem{Text("home")}
            .tag(Tab.home)
            
//            ChatView()
//            .tabItem{Text("chat")}
//            .tag(Tab.chat)
        }
        .background(Color.bg)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


enum Tab{
    case home, chat
}
