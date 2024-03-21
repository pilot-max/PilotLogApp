//
//  AircraftTypeFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

extension AircraftType {
    static func factory() -> AircraftType {
        let letters = ["ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"]
        let numbers = ["1234567890"]
        let name = ["Polky", "Grandios", "Flakey", "Boing", "Errrrbus"].randomElement()!
        let iata = (0..<2).map{ _ in [letters, numbers].joined().randomElement()! }.joined()
        let icao = "\([letters, numbers].joined().randomElement()!)\(iata)"
        
        return AircraftType(
            manufacturer: name,
            name: name,
            icao: icao,
            iata: iata,
            numberOfEngines: Int.random(in: 1...4),
            engineType: EngineType.allCases.randomElement()!
        )
    }
    
    static func factory(take: Int) -> [AircraftType] {
        var types:[AircraftType] = []
        
        _ = (0..<take).map { _ in
            types.append(factory())
        }
        
        return types
    }
}
