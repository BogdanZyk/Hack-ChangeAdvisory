//
//  LpginViewModel.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//


import Combine

class LoginViewModel: ObservableObject {
    
    @Published var login: String = ""
    @Published var password: String = ""
    
    let userService: UserServicesProtocol
    
    private var cansellable = Set<AnyCancellable>()
    
    init(userService: UserServicesProtocol = UserServices()){
        self.userService = userService
        
        userService.logIn(UserAuth(login: "brazil", password: "brazil_142".sha256()))
            .sink { competion in
                switch competion{
                    
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cansellable)

    }
}




