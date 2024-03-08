//
//  AircraftType.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-07.
//

import Foundation

struct AircraftType: Identifiable, Codable, Equatable {
    var id: String { icao }
    var manufacturer: String
    var name: String
    var icao: String
    var iata: String
    var numberOfEngines: Int
    var engineType: EngineType
    var isMultiCrew: Bool
    var isHighPerformance: Bool
    
    /* Engine Computed Properties */
    var isMultiEngine: Bool {
        numberOfEngines > 1
    }
    var isGlider: Bool {
        numberOfEngines == 0
    }
    var isHelicopter: Bool {
        engineType.isRotary
    }
}
