//
//  Aircraft.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-07.
//

import Foundation

struct Aircraft: Codable, Identifiable {
    var id: UUID
    var registration: String
    var tailNumber: String?
    var type: AircraftType
    var airline: Airline
    var isActive: Bool = true
    
    internal init(registration: String, tailNumber: String? = nil, type: AircraftType, airline: Airline, isActive: Bool = true) {
        self.id = UUID()
        self.registration = registration
        self.tailNumber = tailNumber
        self.type = type
        self.airline = airline
        self.isActive = isActive
    }
}
