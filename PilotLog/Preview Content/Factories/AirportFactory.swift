//
//  AirportFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Fakery
import Foundation

extension Airport {
    
    static func factory() -> Airport {
        let faker = Faker()
        let airportNameSuffix = ["Airport", "International", "Strip"]
        
        let continent = ["NA", "SA", "EU", "AS", "OC"].randomElement()!
        let iso_country = faker.address.countryCode()
        let municipality = faker.address.city()
        
        return Airport(
            id: Int.random(in: 0...1000),
            ident: faker.lorem.characters(amount: 4).uppercased(),
            type: AirportType.allCases.randomElement()!,
            name: "\(municipality) \(airportNameSuffix.randomElement()!)",
            latitude_deg: Double.random(in: -90...90),
            longitude_deg: Double.random(in: -180...180),
            continent: continent,
            iso_country: iso_country,
            iso_region: "\(continent)_\(iso_country)",
            municipality: municipality
        )
    }
    
    static func factory(take: Int) -> [Airport] {
        var airports:[Airport] = []
        
        _ = (0..<take).map { _ in
            airports.append(factory())
        }
        
        return airports
    }
}
