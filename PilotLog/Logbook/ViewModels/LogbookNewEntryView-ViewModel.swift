//
//  LogbookNewEntryView-ViewModel.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-15.
//

import Foundation
import SwiftUI

extension LogbookNewEntryView {
    class ViewModel: ObservableObject {
        @Environment(\.managedObjectContext) var moc
        
        @State var showLoadingIndicator = false
        
        @Published var date: Date
        @Published var dutyType: String
        @Published var departure: String
        @Published var arrival: String
        @Published var timeOut: Date { didSet { calculateFlightTimes() } }
        @Published var timeOff: Date { didSet { calculateFlightTimes() } }
        @Published var timeOn: Date { didSet { calculateFlightTimes() } }
        @Published var timeIn: Date { didSet { calculateFlightTimes() } }
        @Published var scheduledTimeOut: Date
        @Published var scheduledTimeOff: Date
        @Published var scheduledTimeOn: Date
        @Published var scheduledTimeIn: Date
        var blockTimeInMinutes = 0
        var airTimeInMinutes = 0
        var blockTime = "00:00"
        var airTime = "00:00"
        
        func saveFlight() throws {
            do {
                try validateForm()
            } catch {
                throw error
            }
            
            let entry = Flight(context: moc)
            entry.date = date
            entry.duty_type = dutyType
            entry.route_departure = departure
            entry.route_arrival = arrival
            entry.date_out = timeOut
            entry.date_off = timeOff
            entry.date_on = timeOn
            entry.date_in = timeIn
            entry.time_minutes_air = Int16(airTimeInMinutes)
            entry.time_minutes_block = Int16(blockTimeInMinutes)
            
            try moc.save()
        }
        
        func validateForm() throws {
            // Date is not in future
            if date.compare(Date()).rawValue > 0 {
                throw FlightEntryError.fieldError(.date, message: "Date cannot be in the future.")
            }
            
            // Duty type is valid
            
            // Departure is valid
            if departure == "" {
                throw FlightEntryError.fieldError(.departure, message: "You must select a departure airport.")
            }
            // Arrival is valid
            if arrival == "" {
                throw FlightEntryError.fieldError(.arrival, message: "You must select an arrival airport.")
            }
            
            // Out and In are valid
            if blockTimeInMinutes < 0 {
                throw FlightEntryError.fieldError(.blockTime, message: "Out time must be earlier than the In time.")
            }
            
            // Off and On are valid
            if airTimeInMinutes < 0 {
                throw FlightEntryError.fieldError(.blockTime, message: "Takeoff time must be earlier than the Landing time.")
            }
            if airTimeInMinutes > blockTimeInMinutes {
                throw FlightEntryError.fieldError(.airTime, message: "Air time cannot be greater than block time.")
            }
        }
        
        func calculateFlightTimes() {
            guard let flightTimes = try? FlightTimes(brakesReleased: timeOut, takeoff: timeOff, landing: timeOn, brakesSet: timeIn) else {
                return
            }
            
            blockTimeInMinutes = flightTimes.blockTimeInMinutes
            airTimeInMinutes = flightTimes.airTimeInMinutes
            blockTime = flightTimes.blockTimeClockFormat
            airTime = flightTimes.airTimeClockFormat
        }
        
        init() {
            self.date = Date()
            self.dutyType = DutyType.flight.rawValue
            self.departure = ""
            self.arrival = ""
            self.timeOut = Date()
            self.timeOff = Date()
            self.timeOn = Date()
            self.timeIn = Date()
            self.scheduledTimeOut = Date()
            self.scheduledTimeOff = Date()
            self.scheduledTimeOn = Date()
            self.scheduledTimeIn = Date()
        }
    }
}
