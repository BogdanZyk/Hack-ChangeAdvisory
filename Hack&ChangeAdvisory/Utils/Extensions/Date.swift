//
//  Date.swift
//  Hack&ChangeAdvisory
//
//  Created by Bogdan Zykov on 13.11.2022.
//

import Foundation

extension Date {
    
    static var currentTimeStamp: Int{
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
}






extension Date {
    /// Date to Unix timestamp.
    var unixTimestamp: Int {
        return Int(self.timeIntervalSince1970 * 1_000) // millisecond precision
    }
}

extension Int {
    /// Unix timestamp to date.
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1_000)) // must take a millisecond-precise Unix timestamp
    }
}


