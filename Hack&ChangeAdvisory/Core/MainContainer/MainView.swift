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
                .tabItem{
                    VStack{
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
                .tag(Tab.home)
            
            NavigationView {
                ChatView()
                
            }
            .tabItem{
                VStack{
                    Image(systemName: "text.bubble.fill")
                    Text("Chat")
                }
            }
            .tag(Tab.chat)
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
