//
//  FlightTimesError.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-06.
//

import Foundation

enum FlightTimesError: Error {
    case airTimeGreaterThanBlockTime
    case timesNotSet
    case negativeAirTime
    case negativeBlockTime
    case brakesReleasedAfterTakeoff
    case brakesSetPriorToLanding
}
