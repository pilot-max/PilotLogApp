//
//  DateHelper.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-01.
//

import Foundation

struct DateHelper {
    static func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian)
        return userCalendar.date(from: dateComponents) ?? Date()
    }
}

func date(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
    return DateHelper.createDate(year: year, month: month, day: day, hour: hour, minute: minute)
}
