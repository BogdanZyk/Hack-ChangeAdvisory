//
//  Helpers.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 13.11.2022.
//

import Foundation


class Helpers{
   static func convertToDictionary(from text: String) -> [String: String]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: String]
    }
}
