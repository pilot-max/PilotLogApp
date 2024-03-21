//
//  AircraftType.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-07.
//

import Foundation
import SwiftData

@Model
class AircraftType {
    var id: UUID
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
    
    init(manufacturer: String, name: String, icao: String, iata: String, numberOfEngines: Int, engineType: EngineType, isMultiCrew: Bool = false, isHighPerformance: Bool = false) {
        self.id = UUID()
        self.manufacturer = manufacturer
        self.name = name
        self.icao = icao
        self.iata = iata
        self.numberOfEngines = numberOfEngines
        self.engineType = engineType
        self.isMultiCrew = isMultiCrew
        self.isHighPerformance = isHighPerformance
    }
}
