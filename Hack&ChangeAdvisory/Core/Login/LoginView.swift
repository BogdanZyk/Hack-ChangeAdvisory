//
//  LoginView.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
    var body: some View {
        VStack(spacing: 20){
            title
            loginTf
            passTf
            loginButton
            Spacer()
        }
        .padding()
        .foregroundColor(.foreground)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


extension LoginView{
    private var title: some View{
        Text("Вход")
            .font(.system(size: 30, weight: .bold))
            .padding(.bottom, 20)
    }
    
    private var loginTf: some View{
        VStack(alignment: .leading) {
            Text("Логин")
                .font(.subheadline)
            PrimaryTextField(label: "Логин", text: $loginVM.login)
        }
    }
    private var passTf: some View{
        VStack(alignment: .leading) {
            Text("Пароль")
                .font(.subheadline)
            PrimaryTextField(secure: true, label: "Пароль", text: $loginVM.password)
        }
    }
    private var loginButton: some View{
        PrimaryButtonView(showLoader: loginVM.showLoader, title: "Войти") {
            loginVM.logIn()
        }
        .padding(.top, 10)
    }
}
