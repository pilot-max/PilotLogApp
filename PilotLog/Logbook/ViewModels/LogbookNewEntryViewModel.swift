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
                self.blockTime = flightTimes.blockTimeClockFormat
                print(blockTime)
            }
            get { flightTimes.brakesReleased ?? Date() }
        }
        var offTime: Date {
            set {
                try? flightTimes.setTime(takeoff: newValue)
                airTime = flightTimes.airTimeClockFormat
                
            }
            get { flightTimes.takeoff ?? Date() }
        }
        var onTime: Date {
            set {
                try? flightTimes.setTime(landing: newValue)
                airTime = flightTimes.airTimeClockFormat
            }
            get { flightTimes.landing ?? Date() }
        }
        var inTime: Date {
            set {
                try? flightTimes.setTime(brakesSet: newValue)
                blockTime = flightTimes.blockTimeClockFormat
            }
            get { flightTimes.brakesSet ?? Date() }
        }
        @Published var blockTime = ""
        @Published var airTime = ""
        @Published var departureAirport = ""
        @Published var arrivalAirport = ""
        
        let timeFormatter: Formatter = {
            let formatter = TimeFormatter()
            return formatter
        }()
        
        init() {
            self.flightTimes = try! FlightTimes(departureDate: Date(), brakesReleased: Date(), takeoff: Date(), landing: Date(), brakesSet: Date())
            self.arrivalDate = Date()
        }
    }
}
