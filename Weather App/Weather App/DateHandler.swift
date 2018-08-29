//
//  DateHandler.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import Foundation

class DateHandler {
    static let Offset = 10
    static var todaysDate: String {
        return FormatDateString(date: Date())
    }
    static var tomorrowsDate: String {
        guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else {
            return ""
        }
        return FormatDateString(date: tomorrowDate)
    }
    
    static func FormatDateString(date: Date) -> String {
        let dateString = String(describing: date)
        let endIndex = dateString.index(dateString.startIndex, offsetBy: Offset)
        return String(dateString[..<endIndex])
    }
}
