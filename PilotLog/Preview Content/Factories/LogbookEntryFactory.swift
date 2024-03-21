//
//  LogbookEntryFactory.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-21.
//

import Fakery
import Foundation

extension LogbookEntry {
    static func factory () -> LogbookEntry {
        let faker = Faker()
        let date = faker.date.birthday(0, 1)
        let blockTime = Int.random(in: 90...6000)
        let airTime = blockTime - Int.random(in: 10...80)
        let times = try! FlightTimes(block: blockTime, air: airTime)
        return LogbookEntry(date: date, times: times)
    }
    
    static func factory(take: Int) -> [LogbookEntry] {
        var entries:[LogbookEntry] = []
        
        _ = (0..<take).map { _ in
            entries.append(factory())
        }
        
        return entries.sorted(by: { $0.date > $1.date })
    }
}
