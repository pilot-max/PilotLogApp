//
//  Airline.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-07.
//

import Foundation

struct Airline: Codable, Identifiable {
    var id: String { icao }
    let name: String
    let icao: String
    let iata: String
    let active: Bool
    let country: String
}
