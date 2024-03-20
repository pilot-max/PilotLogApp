//
//  AirportType.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

enum AirportType: Codable {
    case large_airport
    case medium_airport
    case small_airport
    case seaplane_base
    case heliport
    case closed
    
    var description: String {
        switch self {
        case .large_airport:
            return "Large Airport"
        case .medium_airport:
            return "Medium Airport"
        case .small_airport:
            return "Small Airport"
        case .seaplane_base:
            return "Seaplane Base"
        case .heliport:
            return "Heliport"
        case .closed:
            return "Closed Aerodrome"
        }
    }
}
