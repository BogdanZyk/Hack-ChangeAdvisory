//
//  HomeViewModel.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject{
    
    let userService: UserServicesProtocol
    let userManager = UserManager.share
    @Published var currentUser: User?
    
    private var cancellable = Set<AnyCancellable>()
    
    init(userService: UserServicesProtocol = UserServices()){
        self.userService = userService
        getCurrentUser()
    }
    
    func getCurrentUser(){
        userService.getCurrentUser()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkController.share.handlingCompletion(completion: completion)
            } receiveValue: { user in
                self.currentUser = user
                self.userManager.currentUser = user
            }
            .store(in: &cancellable)
    }
    
    
}
