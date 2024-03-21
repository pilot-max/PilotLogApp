//
//  AircraftFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Fakery
import Foundation

extension Aircraft {
    static func factory() -> Aircraft {
        let faker = Faker()
        
        let registration = faker.lorem.bothify("C-????")
        let tailNumber = String(faker.number.randomInt(min: 100, max: 999))
        let type = AircraftType.factory()
        let airline = Airline.factory()
        let isActive = Bool.random()
        
        return Aircraft(registration: registration, tailNumber: tailNumber, type: type, airline: airline, isActive: isActive)
    }
    
    static func factory(take: Int) -> [Aircraft] {
        var aircraft:[Aircraft] = []
        
        _ = (0..<take).map { _ in
            aircraft.append(factory())
        }
        
        return aircraft
    }
}
