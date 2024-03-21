//
//  AirlineFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

extension Airline {
    static func factory() -> Airline {
        let letters = ["ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"]
        let numbers = ["1234567890"]
        
        let name = ["Peace", "Blue", "Mountain", "Lake", "Green", "Red"].randomElement()
        let iata = (0..<3).map{ _ in [letters, numbers].joined().randomElement()! }.joined()
        let icao = "\([letters, numbers].joined().randomElement())\(iata)"
        let active = Bool.random()
        let country = (0..<2).map{ _ in letters.randomElement()! }.joined()
        
        return Airline(name: name!, icao: icao, iata: iata, active: active, country: country)
    }
    
    static func factory(take: Int) -> [Airline] {
        var airlines:[Airline] = []
        
        (0..<take).map { _ in
            airlines.append(factory())
        }
        
        return airlines
    }
}
