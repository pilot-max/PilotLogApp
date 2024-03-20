//
//  Setup.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import CoreData
import Foundation
import SwiftCSV

struct Setup {
    let container: NSPersistentContainer
    
    static func run() {
        let setup = Setup()
        setup.loadUserDefaults()
        setup.loadAirportsIntoCoreData()
    }
    
    private func loadUserDefaults() {
        let defaults = UserDefaults.standard
        
        // Debug
        defaults.setIfNew(true, forKey: "printDebugMessages")
        
        // Airports
        defaults.setIfNew(3000, forKey: "airportRunwayMinimumLength") // Minimum runway length (longest runway)
        defaults.setIfNew(100, forKey: "airportRunwayMinimumWidth")
        defaults.setIfNew(true, forKey: "airportScheduledService")
        defaults.setIfNew(["NA"], forKey: "airportDisplayContinents")
        defaults.setIfNew(["CA", "US"], forKey: "airportDisplayCountries") // ISO 3166 Codes of Countries to display
        
        // Debug
        Debug.log("UserDefaults loaded.", caller: self)
    }
    
    private func loadAirportsIntoCoreData() {
        let request = NSFetchRequest<Airport>(entityName: "Airport")
        request.fetchLimit = 1
        do {
            if try container.viewContext.fetch(request).count == 0 {
                let data: CSV? = try CSV<Named>(
                        name: "airports",
                        extension: "csv")
                
                try data?.rows.forEach { row in
                    let airport = Airport(context: container.viewContext)
                    airport.setValuesFromDict(row)
                    try container.viewContext.save()
                }
                
//                Airports(container: container).loadAirportsFromFile()
//                if let file = Bundle.main.url(forResource: "Airports", withExtension: "json") {
//                    let data = try Data(contentsOf: file)
//                    let decoder = JSONDecoder()
//                    decoder.userInfo[CodingUserInfoKey.managedObjectContext] = container.viewContext
//                    try decoder.decode([Airport].self, from: data)
//                    try container.viewContext.save()
//                    
//                    // Debug
//                    Debug.log("Airports loaded into CoreData.", caller: self)
//                    
//                    return
//                }
            } else {
                // Debug
                Debug.log("Airports are already loaded into CoreData.", caller: self)
            }
        } catch {
            Debug.log(error, caller: self)
        }
        
    }
    
    init() {
        // Set Up CoreData
        container = NSPersistentContainer(name: "Logbook")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("CoreData error (\(error)): \(error.localizedDescription)")
            }
        }
    }
}
