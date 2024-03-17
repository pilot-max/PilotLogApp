//
//  FlightEntryError.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-16.
//

import Foundation

enum FlightEntryError: Error {
    case fieldError(_ field: Field, message: String = "")
    
    enum Field {
        case date
        case departure
        case arrival
        case blockTime
        case airTime
    }
}
