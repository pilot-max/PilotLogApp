//
//  AircraftFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

extension Aircraft {
    static func factory() -> Aircraft {
        let letters = ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
        let registration = "C-\((0..<4).map{ _ in letters.randomElement()! }.joined())"
        let tailNumber = String(Int.random(in: 100...999))
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
