//
//  FlightTimes.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-01.
//

import Foundation

/// Flight Times model. Used with LogbookEntry.
struct FlightTimes: Codable {
    var departureDate: Date
    private(set) var brakesReleased: Date? = nil
    private(set) var takeoff: Date? = nil
    private(set) var landing: Date? = nil
    private(set) var brakesSet: Date? = nil
    
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
    private mutating func recalculateTimes(changedValue: String? = nil) throws {
        // Set dates
        
        
        // Calculate time ranges
        switch changedValue {
        case "brakesReleased", "brakesSet":
            if brakesReleased != nil && brakesSet != nil {
                blockTimeInMinutes = minutesBetween(brakesReleased!, brakesSet!)
            }
        case "takeoff", "landing":
            if takeoff != nil && landing != nil {
                airTimeInMinutes = minutesBetween(takeoff!, landing!)
            }
        default:
            if brakesReleased != nil && brakesSet != nil {
                blockTimeInMinutes = minutesBetween(brakesReleased!, brakesSet!)
            } else {
                blockTimeInMinutes = 0
            }
            
            if takeoff != nil && landing != nil {
                airTimeInMinutes = minutesBetween(takeoff!, landing!)
            } else {
                airTimeInMinutes = 0
            }
        }
        
        do {
            try validateTimes()
        } catch {
            throw error
        }
    }
    
    /// Validate the time values
    /// - Throws FlightTimesError
    private func validateTimes() throws {
        // Brakes released after takeoff
        if brakesReleased != nil && takeoff != nil {
            if 0 > minutesBetween(brakesReleased!, takeoff!) {
                throw FlightTimesError.brakesReleasedAfterTakeoff
            }
        }
        
        // Brakes set before landing
        if landing != nil && brakesSet != nil {
            if 0 > minutesBetween(landing!, brakesSet!) {
                throw FlightTimesError.brakesSetPriorToLanding
            }
        }
        
        // Block time is a positive number
        if blockTimeInMinutes < 0 {
            throw FlightTimesError.negativeBlockTime
        }
        
        // Air time is a positive number
        if airTimeInMinutes < 0 {
            throw FlightTimesError.negativeAirTime
        }
        
        // Block time is greater than air time
        if blockTimeInMinutes < airTimeInMinutes {
            throw FlightTimesError.airTimeGreaterThanBlockTime
        }
    }
    
    /// Set new brakesReleased value
    /// - Parameter brakesReleased: New brakesReleased value
    mutating func setTime(brakesReleased: Date) throws {
        do {
            self.brakesReleased = brakesReleased
            try recalculateTimes(changedValue: "brakesReleased")
        } catch {
            throw error
        }
    }
    
    /// Set new takeoff value
    /// - Parameter takeoff: New takeoff value
    mutating func setTime(takeoff: Date) throws {
        do {
            self.takeoff = takeoff
            
            try recalculateTimes(changedValue: "takeoff")
        } catch {
            throw error
        }
    }
    
    /// Set new landing value
    /// - Parameter landing: New landing value
    mutating func setTime(landing: Date) throws {
        do {
            self.landing = landing
            
            try recalculateTimes(changedValue: "landing")
        } catch {
            throw error
        }
    }
    
    /// Set new brakesSet value
    /// - Parameter brakesSet: New brakesSet value
    mutating func setTime(brakesSet: Date) throws {
        do {
            self.brakesSet = brakesSet
            
            try recalculateTimes(changedValue: "brakesSet")
        } catch {
            throw error
        }
    }
    
    /// Minutes between dates
    /// - Parameters:
    ///   - start: Start date to compare
    ///   - end: End date to compare
    /// - Returns: Minutes between the start and end dates
    private func minutesBetween(_ start: Date, _ end: Date) -> Int {
        let minutes = Int(Int(end.timeIntervalSince1970 - start.timeIntervalSince1970) / 60)
        
        // Flip over to the next day
        if minutes < 0 {
            return 1440 + minutes
        }
        
        return minutes
    }
    
    /// Initializer for
    /// - Parameters:
    ///   - brakesReleased: The time that the aircraft left the gate. Also known as the out time. Starting value for the block time range.
    ///   - off: The time that the aircraft took off. Starting value for the air time range.
    ///   - on: The time that the aircraft landed. Ending value for the air time range.
    ///   - brakesSet: The time that the aircraft arrived to the gate. Also known as the in time. Ending value for the block time range.
    init(departureDate: Date, brakesReleased: Date, takeoff: Date, landing: Date, brakesSet: Date) throws {
        do {
            self.departureDate = departureDate
            self.brakesReleased = brakesReleased
            self.takeoff = takeoff
            self.landing = landing
            self.brakesSet = brakesSet
            
            try recalculateTimes()
        } catch {
            throw error
        }
    }
    
//    /// Initializer with block and air times precalculated
//    /// - Parameters:
//    ///   - block: The block time in minutes. This is the time logged for total hours.
//    ///   - air: The air time in minutes. This is the time logged for aircraft maintenance and for subtotals including instrument and cross-country time.
//    init(block: Int, air: Int) throws {
//        if block < air {
//            throw FlightTimesError.airTimeGreaterThanBlockTime
//        }
//        
//        self.blockTimeInMinutes = block
//        self.airTimeInMinutes = air
//    }
}
