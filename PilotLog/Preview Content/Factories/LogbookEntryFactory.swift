//
//  LogbookEntryFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-21.
//

import Fakery
import SwiftUI

extension LogbookEntry {
    static func factory () -> LogbookEntry {
        let faker = Faker()
        let date = faker.date.birthday(0, 1)
        let blockTime = Int.random(in: 90...600)
        let airTime = blockTime - Int.random(in: 10...80)
        //let times = try! FlightTimes(block: blockTime, air: airTime)
        let times = try! FlightTimes(departureDate: date, brakesReleased: Date(), brakesSet: Date().advanced(by: 60*60))
        return LogbookEntry(date: date, times: times)
    }
    
    static func factory(take: Int) -> [LogbookEntry] {
        var entries:[LogbookEntry] = []
        
        _ = (0..<take).map { _ in
            entries.append(factory())
        }
        
        return entries.sorted(by: { $0.date > $1.date })
    }
    
//    func factorySectioned(take: Int) -> [String: [LogbookEntry]] {
//        var sectionedEntries: [String: [LogbookEntry]]
//        var currentSection = ""
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM YYYY"
//        
//        let entries = LogbookEntry.factory(take: take)
//        
//        ForEach(entries) { entry in
//            currentSection = entry.date.toString()//formatter.string(from: entry.date)
//            if sectionedEntries[String(currentSection)] == nil {
//                sectionedEntries[String(currentSection)] = []
//            }
//            sectionedEntries[String(currentSection)].append(entry)
//        }
//        
//        return sectionedEntries
//    }
    
    struct Section: Identifiable {
        let id: String
        var entries: [LogbookEntry] = []
    }
}
