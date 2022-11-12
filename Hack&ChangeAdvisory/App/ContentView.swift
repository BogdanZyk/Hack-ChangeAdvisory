//
//  ContentView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userManager = UserManager.share
    var body: some View {
        Group{
            if userManager.isLoggin{
                MainView()
            }else{
                LoginView()
            }
        }
        .onAppear{
            userManager.verifyToken()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
