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
        let brakesReleased = faker.date.birthday(0, 1)
        let takeoff = brakesReleased.addingTimeInterval(TimeInterval(Int.random(in: 1...30)))
        let landing = takeoff.addingTimeInterval(TimeInterval(Int.random(in: 30...600)))
        let brakesSet = landing.addingTimeInterval(TimeInterval(Int.random(in: 1...30)))
        //let times = try! FlightTimes(block: blockTime, air: airTime)
        let times = try! FlightTimes(departureDate: brakesReleased, brakesReleased: brakesReleased, takeoff: takeoff, landing: landing, brakesSet: brakesSet)
        return LogbookEntry(date: brakesReleased, times: times)
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
