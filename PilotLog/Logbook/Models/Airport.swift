//
//  Airport+CoreDataClass.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//
//

import Foundation
import CoreData

@objc(Airport)
public class Airport: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case name, city, country, iata, icao, latitude, longitude, altitude, timezone, timezone_dst
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .icao)
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        iata = try container.decode(String.self, forKey: .iata)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        altitude = try container.decode(Int16.self, forKey: .altitude)
        timezone = try container.decode(String.self, forKey: .timezone)
        timezone_dst = try container.decode(String.self, forKey: .timezone_dst)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .icao)
        try container.encode(name, forKey: .name)
        try container.encode(city, forKey: .city)
        try container.encode(country, forKey: .country)
        try container.encode(iata, forKey: .iata)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(timezone, forKey: .timezone)
        try container.encode(timezone_dst, forKey: .timezone_dst)
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
