//
//  TimeInterval.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import Foundation

extension TimeInterval {
    static func from(week: Double = 0.0, day: Double = 0.0, hour: Double = 0.0, minute: Double = 0.0, second: Double = 0.0) -> TimeInterval {
        return TimeInterval(second + (minute * 60) + (hour * 3600) + (day * 86400) + (week * 604800))
    }
}
