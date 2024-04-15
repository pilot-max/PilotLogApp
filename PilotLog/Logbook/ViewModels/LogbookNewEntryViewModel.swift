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
        @Published var departureAirport = ""
        @Published var arrivalAirport = ""
        
        let timeFormatter: Formatter = {
            let formatter = TimeFormatter()
            return formatter
        }()
        
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
