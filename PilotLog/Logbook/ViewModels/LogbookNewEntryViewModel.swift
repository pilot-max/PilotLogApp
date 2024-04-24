//
//  LogbookNewEntryViewModel.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftUI

extension LogbookNewEntryView {
    class ViewModel: ObservableObject {
        @Published var flightTimes: FlightTimes
        @Published var arrivalDate: Date
        @Published var departureAirport = ""
        @Published var arrivalAirport = ""
        var outTime: Date {
            set {
                try? flightTimes.setTime(brakesReleased: newValue)
            }
            get { flightTimes.brakesReleased ?? Date() }
        }
        var offTime: Date {
            set {
                try? flightTimes.setTime(takeoff: newValue)
            }
            get { flightTimes.takeoff ?? Date() }
        }
        var onTime: Date {
            set {
                try? flightTimes.setTime(landing: newValue)
            }
            get { flightTimes.landing ?? Date() }
        }
        var inTime: Date {
            set {
                try? flightTimes.setTime(brakesSet: newValue)
            }
            get { flightTimes.brakesSet ?? Date() }
        }
        
        let timeFormatter: Formatter = {
            let formatter = TimeFormatter()
            return formatter
        }()
        
        var error = ""
        var showErrorModal = false
        
        func saveEntry() {
            if fieldsAreSetAndValid() {
                let flightEntry = LogbookEntry(times: flightTimes)
            } else {
                // Display error
                print("Fields are not set, or they are invalid")
            }
        }
        
        func fieldsAreSetAndValid() -> Bool {
            // Verify Fields Set
            if departureAirport.isEmpty, arrivalAirport.isEmpty {
                return false
            }
            
            // Validate Fields
            
            
            return true
        }
        
        init() {
            // ToDo: Make UTC
            let currentTime = Date.startOfToday
            self.flightTimes = try! FlightTimes(
                departureDate: currentTime,
                brakesReleased: currentTime,
                takeoff: currentTime,
                landing: currentTime,
                brakesSet: currentTime
            )
            self.arrivalDate = Date()
        }
    }
}
