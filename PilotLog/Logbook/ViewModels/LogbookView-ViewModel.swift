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
        var airports: Airports?
        
        private (set) var entries: [LogbookEntry] = []
        
        func loadSampleData() {
            entries = LogbookEntry.sampleEntries()
        }
        
        /// Fetch the airports from CoreData
        func fetchAirports() {
            airports?.fetchAirports()
//            let request = NSFetchRequest<Airport>(entityName: "Airport")
//            request.predicate = NSPredicate(format: "ANY country in %@", argumentArray: UserDefaults.standard.array(forKey: "airportDisplayCountries"))
//            
//            do {
//                airports = try request.execute()
//            } catch {
//                Debug.log(error, caller: "\(self).fetchAirports()")
//            }
        }
        
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
                    Debug.log(error, caller: self)
                }
            }
            
            airports = Airports(container: container)
            
            fetchAirports()
        }
    }
}
