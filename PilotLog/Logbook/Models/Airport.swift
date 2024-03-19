//
//  Airport+CoreDataClass.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//
//

import CoreData
import SwiftUI

class Airports: ObservableObject {
    let defaults = UserDefaults.standard
    let container: NSPersistentContainer
    
    var array: [Airport]
    var dict: [String: Airport]
    
    func fetchAirports() {
        let request = NSFetchRequest<Airport>(entityName: "Airport")
        if (UserDefaults.standard.array(forKey: "airportDisplayCountries") != nil) {
            //request.predicate = NSPredicate(format: "country in %@", countries)
        }
        
        do {
            array = try container.viewContext.fetch(request).map{ $0 }
            Debug.log("Airports fetched from database.", caller: self)
        } catch {
            Debug.log(error.localizedDescription, caller: "Airport.fetchAirports()")
        }
    }
    
    func load(force: Bool = false) throws {
        Task {
            if array.isEmpty || force {
                fetchAirports()
            }
            
            loadDict(force: force)
        }
    }
    
    func loadDict(force: Bool = false) {
        if dict.isEmpty || force {
            dict.removeAll()
            array.forEach { airport in
                if airport.ident != nil {
                    dict[airport.ident!] = airport
                } else {
                    // All airports should have an ident, but 🤷
                    Debug.log("Airport id: \(airport.id) does not have an identifier.")
                }
            }
        }
    }
    
    func loadAirportsFromFile() {
        Debug.log("Loading airports from file.")
        
        Task {
            do {
                try await loadAirportsFromFile()
            } catch {
                Debug.log("\(error)", caller: self)
            }
        }
    }
    
    /// Load the airports into CoreData
    private func loadAirportsFromFile() async throws {
        if let filepath = Bundle.main.path(forResource: "airports.csv", ofType: nil) {
            do {
                let fileContent = try String(contentsOfFile: filepath)
                let lines = fileContent.components(separatedBy: "\n")
                var results: [String:String] = [:]
                lines.dropFirst().forEach { line in
                    let data = line.components(separatedBy: ",")
                    if data.count == 2 {
                        results[data[0]] = data[1]
                    }
                }
                print(results)
            } catch {
                print("error: \(error)") // to do deal with errors
            }
        } else {
            print("airports.csv could not be found")
        }
        
    }
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.array = []
        self.dict = [:]
    }
}

@objc(Airport)
public class Airport: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id,
             ident,
             type,
             name,
             latitude_deg,
             longitude_deg,
             elevation_ft,
             continent,
             iso_country,
             iso_region,
             municipality,
             scheduled_service,
             gps_code,
             iata_code,
             local_code,
             runway_length_ft,
             runway_width_ft,
             runway_lighted
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int32.self, forKey: .id)
        ident = try container.decode(String.self, forKey: .ident)
        type = try container.decode(String.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        latitude_deg = try container.decode(Double.self, forKey: .latitude_deg)
        longitude_deg = try container.decode(Double.self, forKey: .longitude_deg)
        elevation_ft = try container.decode(Int16.self, forKey: .elevation_ft)
        continent = try container.decode(String.self, forKey: .continent)
        iso_country = try container.decode(String.self, forKey: .iso_country)
        iso_region = try container.decode(String.self, forKey: .iso_region)
        municipality = try container.decode(String.self, forKey: .municipality)
        scheduled_service = try container.decode(Bool.self, forKey: .scheduled_service)
        gps_code = try container.decode(String.self, forKey: .gps_code)
        iata_code = try container.decode(String.self, forKey: .iata_code)
        local_code = try container.decode(String.self, forKey: .local_code)
        runway_length_ft = try container.decode(Int16.self, forKey: .runway_length_ft)
        runway_width_ft = try container.decode(Int16.self, forKey: .runway_width_ft)
        runway_lighted = try container.decode(Bool.self, forKey: .runway_lighted)
//        timezone = try container.decode(String.self, forKey: .timezone)
//        timezone_dst = try container.decode(String.self, forKey: .timezone_dst)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(ident, forKey: .ident)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(latitude_deg, forKey: .latitude_deg)
        try container.encode(longitude_deg, forKey: .longitude_deg)
        try container.encode(elevation_ft, forKey: .elevation_ft)
        try container.encode(continent, forKey: .continent)
        try container.encode(iso_country, forKey: .iso_country)
        try container.encode(iso_region, forKey: .iso_region)
        try container.encode(municipality, forKey: .municipality)
        try container.encode(scheduled_service, forKey: .scheduled_service)
        try container.encode(gps_code, forKey: .gps_code)
        try container.encode(iata_code, forKey: .iata_code)
        try container.encode(local_code, forKey: .local_code)
        try container.encode(runway_length_ft, forKey: .runway_length_ft)
        try container.encode(runway_width_ft, forKey: .runway_width_ft)
        try container.encode(runway_lighted, forKey: .runway_lighted)
//        try container.encode(timezone, forKey: .timezone)
//        try container.encode(timezone_dst, forKey: .timezone_dst)
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
