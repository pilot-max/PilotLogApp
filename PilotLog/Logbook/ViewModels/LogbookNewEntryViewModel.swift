//
//  LogbookNewEntryViewModel.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftUI

extension LogbookNewEntryView {
    class ViewModel {
        @Published var departureDate: Date
        @Published var arrivalDate: Date
        @Published var outTime: Date
        @Published var inTime: Date
        @Published var departureAirport = ""
        @Published var arrivalAirport = ""
        
        init() {
            self.departureDate = Date()
            self.arrivalDate = Date()
            self.outTime = Date()
            self.inTime = Date()
        }
    }
}
