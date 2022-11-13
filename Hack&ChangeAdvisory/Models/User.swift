//
//  User.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 12.11.2022.
//

import Foundation


struct User: Codable{
    var userId: Int
    var avatar: String?
    var surname: String?
    var name: String?
    var middleName: String?
    
    var fullName: String{
        (name ?? "").capitalized + " " + (surname ?? "").capitalized
    }
}


struct UserResponse: Codable{
    var userId: Int
    var login: String
    var role: UserRole
    var jwtToken: String
}

struct UserAuth: Codable{
    var login: String
    var password: String
}

struct VerifyRequest: Codable{
    let jwt: String
}

struct VerifyResponse: Codable{
    let userId: Int
    let role: UserRole
}

enum UserRole: String, Codable{
    case client = "CLIENT"
    case `operator` = "OPERATOR"
}
