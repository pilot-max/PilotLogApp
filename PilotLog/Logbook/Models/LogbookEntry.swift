//
//  LogbookEntry.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import Foundation

struct LogbookEntry {
    let id: UUID
    //var date: Date
    //var aircraft: Aircraft
    //var flightNumber: String
    //var route: FlightRoute
    var times: FlightTimes
}

//struct LogbookEntry: Identifiable, Codable {
//    let id: UUID
//    var day: Int
//    var month: Int
//    var year: Int
//    var date: Date
//    var aircraftRegistration: String
//    var flightNumber: String?
//    var totalTime: Double
//    var departure: String
//    var arrival: String
//
//    // New initializer
//    init(id: UUID, day: Int, month: Int, year: Int, aircraftRegistration: String, flightNumber: String? = nil, totalTime: Double, departure: String, arrival: String) {
//        var components = DateComponents(
//            year: year,
//            month: month,
//            day: day
//        )
//
//        self.id = id
//        self.day = day
//        self.month = month
//        self.year = year
//        self.date = Calendar.current.date(from: components)!
//        self.aircraftRegistration = aircraftRegistration
//        self.flightNumber = flightNumber
//        self.totalTime = totalTime
//        self.departure = departure
//        self.arrival = arrival
//    }
//
//    // "Legacy" initializer... seriously? We're only three days into coding this app
//    init(id: UUID = UUID(), date: Date, aircraftRegistration: String, flightNumber: String? = nil, totalTime: Double, departure: String, arrival: String) {
//        // Break apart Date
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day, .month, .year], from: date)
//
//        self.id = id
//        self.day = components.day ?? 1
//        self.month = components.month ?? 1
//        self.year = components.year ?? 1970
//        self.date = date
//        self.aircraftRegistration = aircraftRegistration
//        self.flightNumber = flightNumber
//        self.totalTime = totalTime
//        self.departure = departure
//        self.arrival = arrival
//    }
//
//        func dayOfMonth() -> Int {
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.day], from: Date())
//            return components.day ?? 0
//        }
//
//        func dayOfWeek() -> String {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "E"
//            return dateFormatter.string(from: date)
//        }
//
//    func totalTimeDecimal() -> String {
//        totalTime.formatted(.number.precision(.fractionLength(1)))
//    }
//
//    func title () -> String {
//        flightNumber ?? aircraftRegistration
//    }
//}
//
//extension LogbookEntry {
//    static let sampleData = LogbookEntry(date: Date(), aircraftRegistration: "C-FNEN", flightNumber: "WEN1234", totalTime: 1.5, departure: "CYUL", arrival: "CYYZ")
//    static let sampleList = [
//        LogbookEntry(date: Date(), aircraftRegistration: "C-FNEN", flightNumber: "WEN1234", totalTime: 1.5, departure: "CYUL", arrival: "CYYZ"),
//        LogbookEntry(date: Date() - (TimeInterval.from(day: 2)), aircraftRegistration: "C-GJWE", totalTime: 1.1, departure: "CYUL", arrival: "CYYZ"),
//        LogbookEntry(date: Date() - (TimeInterval.from(day: 2)), aircraftRegistration: "C-GJWE", flightNumber: "WEN4321", totalTime: 1.3, departure: "CYYZ", arrival: "CYUL"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 1)), aircraftRegistration: "C-FTEN", totalTime: 2.1, departure: "CYQT", arrival: "CYYZ"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 1)), aircraftRegistration: "C-FTEN", totalTime: 1.4, departure: "CYWG", arrival: "CYQT"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 1, day: 2)), aircraftRegistration: "C-GJWE", totalTime: 1.2, departure: "CYXE", arrival: "CYWG"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 1, day: 2)), aircraftRegistration: "C-GJWE", totalTime: 1.1, departure: "CYUL", arrival: "CYYZ"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week:1 ,day: 2)), aircraftRegistration: "C-GJWE", totalTime: 1.3, departure: "CYYZ", arrival: "CYUL"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 2)), aircraftRegistration: "C-FTEN", totalTime: 2.1, departure: "CYQT", arrival: "CYYZ"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 2)), aircraftRegistration: "C-FTEN", totalTime: 1.4, departure: "CYWG", arrival: "CYQT"),
//        LogbookEntry(date: Date() - (TimeInterval.from(week: 2, day: 2)), aircraftRegistration: "C-GJWE", totalTime: 1.2, departure: "CYXE", arrival: "CYWG"),
//    ]
//}
