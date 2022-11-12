//
//  UserManager.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import SwiftUI
import Combine

final class UserManager: ObservableObject{
    
    @AppStorage("isLoggin") var isLoggin = false
    
    static let share = UserManager()
    let userService = UserService()
    let defaults = UserDefaults.standard
    @Published var currentUser: User?
    @Published var userRole: UserRole?
    private var cancellable = Set<AnyCancellable>()
    
    
    
    
    func logOut(){
        defaults.removeObject(forKey: "JWT")
        isLoggin = false
    }
}

// MARK: API

extension UserManager{
    
    /// check is loggin user status
    func verifyToken(){
        userService.verifyJWT()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkController.share.handlingCompletion(completion: completion)
            } receiveValue: { response in
                self.userRole = response.role
                withAnimation{
                    self.isLoggin = true
                }
            }
            .store(in: &cancellable)

    }
}
