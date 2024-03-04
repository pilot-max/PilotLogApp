//
//  FlightTimes.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-01.
//

import Foundation

/// Flight Times model. Used with LogbookEntry.
struct FlightTimes {
    var brakesSet: Date? {
        get { times["out"] ?? nil }
        set {
            times["out"] = newValue
            recalculateTimes(changedValue: "out")
        }
    }
    var takeoff: Date? {
        get { times["off"] ?? nil }
        set {
            times["off"] = newValue
            recalculateTimes(changedValue: "off")
        }
    }
    var landing: Date? {
        get { times["on"] ?? nil }
        set {
            times["on"] = newValue
            recalculateTimes(changedValue: "on")
        }
    }
    var brakesReleased: Date? {
        get { times["in"] ?? nil }
        set {
            times["in"] = newValue
            recalculateTimes(changedValue: "out")
        }
    }
    
    private var times: [String: Date?] = [
        "out": nil,
        "off": nil,
        "on": nil,
        "in": nil
    ]
    
    /// Block time in minutes
    var blockTimeInMinutes: Int = 0
    /// Air time in minutes
    var airTimeInMinutes: Int = 0
    
    /// Block time in clock format (01:23)
    var blockTimeClockFormat: String {
        let hours = Int(blockTimeInMinutes / 60)
        let minutes = Int(blockTimeInMinutes - hours * 60)
        return "\(hours):\(String(format: "%02i", minutes))"
    }
    /// Air time in clock format (01:23)
    var airTimeClockFormat: String {
        let hours = Int(airTimeInMinutes / 60)
        let minutes = Int(airTimeInMinutes - hours * 60)
        return "\(hours):\(String(format: "%02i", minutes))"
    }
    
    /// Recalculate air and block total times
    /// - Parameter changedValue: The key of the value changed. Optional. Will recalculate everything if omitted.
    private mutating func recalculateTimes(changedValue: String? = nil) {
        switch changedValue {
        case "out", "in":
            if times["out"] != nil && times["in"] != nil {
                blockTimeInMinutes = minutesBetween(times["out"]!!, times["in"]!!)
            }
            return
        case "off", "on":
            if times["off"] != nil && times["on"] != nil {
                airTimeInMinutes = minutesBetween(times["off"]!!, times["on"]!!)
            }
            return
        default:
            if times["out"] != nil && times["in"] != nil {
                blockTimeInMinutes = minutesBetween(times["out"]!!, times["in"]!!)
            } else {
                blockTimeInMinutes = 0
            }
            
            if times["off"] != nil && times["on"] != nil {
                airTimeInMinutes = minutesBetween(times["off"]!!, times["on"]!!)
            } else {
                airTimeInMinutes = 0
            }
        }
    }
    /// Minutes between dates
    /// - Parameters:
    ///   - start: Start date to compare
    ///   - end: End date to compare
    /// - Returns: Minutes between the start and end dates
    private func minutesBetween(_ start: Date, _ end: Date) -> Int {
        Int(Int(end.timeIntervalSince1970 - start.timeIntervalSince1970) / 60)
    }
    
    init(out brakesReleased: Date? = nil, off: Date? = nil, on: Date? = nil, in brakesSet: Date? = nil) {
        self.times = [
            "out": brakesReleased,
            "off": off,
            "on": on,
            "in": brakesSet
        ]
        
        recalculateTimes()
    }
    
    init(block: Int, air: Int) {
        self.blockTimeInMinutes = block
        self.airTimeInMinutes = air
    }
}
