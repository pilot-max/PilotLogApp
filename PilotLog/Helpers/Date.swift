//
//  Date.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-10-04.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: self)
    }
    
    var zeroSeconds: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)
    }
    
    static var zeroSeconds: Date {
        Date().zeroSeconds!
    }
    
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: .now)
    }
}
