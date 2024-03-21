//
//  AirlineFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Fakery
import Foundation

extension Airline {
    static func factory() -> Airline {
        let faker = Faker()
        
        let name = faker.company.name()
        let iata = faker.lorem.characters(amount: 2).uppercased()
        let icao = faker.lorem.characters(amount: 3).uppercased()
        let active = Bool.random()
        let country = faker.address.countryCode()
        
        return Airline(name: name, icao: icao, iata: iata, active: active, country: country)
    }
    
    static func factory(take: Int) -> [Airline] {
        var airlines:[Airline] = []
        
        (0..<take).map { _ in
            airlines.append(factory())
        }
        
        return airlines
    }
}
