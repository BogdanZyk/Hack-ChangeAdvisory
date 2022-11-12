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
}


struct UserResponse: Codable{
    var userId: Int
    var login: String
    var role: String
    var jwtToken: String
}

struct UserAuth: Codable{
    var login: String
    var password: String
}


