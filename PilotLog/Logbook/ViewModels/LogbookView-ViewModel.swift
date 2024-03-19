//
//  LogbookView-ViewModel.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-08.
//

import CoreData
import Foundation

extension LogbookView {
    @Observable
    class ViewModel {
        let container: NSPersistentContainer
        var airports: [Airport] = []
        
        private (set) var entries: [LogbookEntry] = []
        
        func loadSampleData() {
            entries = LogbookEntry.sampleEntries()
        }
        
        /// Fetch the airports from CoreData
        func fetchAirports() {
            let request = NSFetchRequest<Airport>(entityName: "Airport")
            request.predicate = NSPredicate(format: "ANY country in %@", argumentArray: UserDefaults.standard.array(forKey: "airportDisplayCountries"))
            
            do {
                airports = try request.execute()
            } catch {
                Debug.log(error.localizedDescription, caller: self)
            }
        }
        
        /// Add a new airport
        /// - Parameters:
        ///   - id: The ICAO code for the airport (CYYZ)
        ///   - name: The name of the airport (Toronto Pearson International Airport)
        ///   - city: The city (Toronto)
        ///   - country: The country (Canada)
        ///   - iata: The IATA code (YYZ)
        ///   - latitude: The latitude in decimal (43.6771)
        ///   - longitude: The longitude in decimal (-79.6334)
        ///   - altitude: The altitude in feet (569)
        ///   - timezone: The timezone
        ///   - timezone_dst: The timezone daylight savings code
//        func addAirport(id: String, name: String, city: String, country: String, iata: String = "", latitude: Double, longitude: Double, altitude: Int = 0, timezone: String, timezone_dst: String = "") {
//            let newAirport = Airport(context: container.viewContext)
//            newAirport.id = id
//            newAirport.name = name
//            newAirport.city = city
//            newAirport.country = country
//            newAirport.iata = iata
//            newAirport.latitude = latitude
//            newAirport.longitude = longitude
//            newAirport.altitude = Int16(altitude)
//            newAirport.timezone = timezone
//            newAirport.timezone_dst = timezone_dst
//            save()
//        }
        
        func save() {
            do {
                try container.viewContext.save()
                fetchAirports()
            } catch {
                print(error)
            }
        }
        
        init() {
            container = NSPersistentContainer(name: "Logbook")
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    print("CoreData error (\(error)): \(error.localizedDescription)")
                }
            }
            
            fetchAirports()
        }
    }
}
