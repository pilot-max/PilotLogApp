//
//  AircraftTypeFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Fakery
import Foundation

extension AircraftType {
    static func factory() -> AircraftType {
        let faker = Faker()
        let name = faker.company.name()
        let iata = faker.lorem.letterify("???").uppercased()
        let icao = "\(faker.lorem.character().uppercased())\(iata)"
        
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
