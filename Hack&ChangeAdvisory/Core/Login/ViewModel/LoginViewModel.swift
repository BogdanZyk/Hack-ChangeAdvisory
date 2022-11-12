//
//  LpginViewModel.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//


import Combine
import Foundation

class LoginViewModel: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var showLoader: Bool = false
    
    let userService: UserServiceProtocol
    let userManager = UserManager.share
    
    private var cansellable = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
    }
    
    func logIn(){
        showLoader = true
        userService.logIn(UserAuth(login: login, password: password.sha256()))
            .receive(on: DispatchQueue.main)
            .sink {[weak self] competion in
                guard let self = self else {return}
                switch competion{
                case .finished:
                    self.showLoader = false
                case .failure(let error):
                    self.showLoader = false
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self]  response in
                guard let self = self else {return}
                let token = response.jwtToken
                self.defaults.set(token, forKey: "JWT")
                self.userManager.verifyToken()
            }
            .store(in: &cansellable)
    }
    

}




