//
//  AirportFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

extension Airport {
//    @Attribute(.unique) var id: Int
//    @Attribute(.unique) var ident: String
//    var type: AirportType
//    var name: String
//    var latitude_deg: Double
//    var longitude_deg: Double
//    var elevation_ft: Int
//    var continent: String
//    var iso_country: String
//    var iso_region: String
//    var municipality: String
//    var scheduled_service: Bool
//    var gps_code: String?
//    var iata_code: String?
//    var local_code: String?
//    var runway_length_ft: Int
//    var runway_width_ft: Int
//    var runway_lighted: Bool
    
    static func factory() -> Airport {
        let names = [
            "prefix": ["Little", "Big", "Round", "Fresh", "Red", "Blue"],
            "main": ["Lake", "Mountain", "Bend", "Plains", "Billy", "Deer", "Castle"],
            "suffix": ["Airport", "International", "Strip"]
        ]
        
        let letters = ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
        let continent = ["NA", "SA", "EU", "AS", "OC"].randomElement()
        let iso_country = (0..<2).map{ _ in letters.randomElement()! }.joined()
        let municipality = "\(names["prefix"]!.randomElement()) \(names["main"]!.randomElement())"
        
        return Airport(
            id: Int.random(in: 0...1000),
            ident: (0..<4).map{ _ in letters.randomElement()! }.joined(),
            type: AirportType.allCases.randomElement()!,
            name: "\(municipality) \(names["suffix"]!.randomElement())",
            latitude_deg: Double.random(in: -100...100),
            longitude_deg: Double.random(in: -100...100),
            continent: continent!,
            iso_country: iso_country,
            iso_region: "\(continent)_\(iso_country)",
            municipality: municipality)
    }
    
    static func factory(take: Int) -> [Airport] {
        var airports:[Airport] = []
        
        (0..<take).map { _ in
            airports.append(factory())
        }
        
        return airports
    }
}
