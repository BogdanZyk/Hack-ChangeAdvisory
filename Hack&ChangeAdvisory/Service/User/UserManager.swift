//
//  UserManager.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation
import SwiftUI

final class UserManager: ObservableObject{
    
    static let share = UserManager()
    let defaults = UserDefaults.standard
    
    var userRole: String = ""
    
    @AppStorage("isLoggin") var isLoggin = false
    
    
    private init(){
        checkIsLogin()
    }
    
    func checkIsLogin(){
        DispatchQueue.main.async {
            self.isLoggin = self.defaults.string(forKey: "JWT") != nil
            self.userRole = self.defaults.string(forKey: "ROLE") ?? ""
        }
    }
    
    func logOut(){
        defaults.removeObject(forKey: "JWT")
        checkIsLogin()
    }
}
