//
//  FlightTimesTests.swift
//  PilotLogTests
//
//  Created by Max Udaskin on 2024-03-03.
//

import XCTest
@testable import PilotLog

final class FlightTimesTests: XCTestCase {
    /* Init Tests */
    func testInitWithBlockAndAirTimes() {
        do {
            // Arrange
            let block = 60
            let air = 60
            
            // Act
            let flightTimes = try FlightTimes(block: block, air: air)
            
            // Assert
            XCTAssertEqual(flightTimes.blockTimeInMinutes, block)
            XCTAssertEqual(flightTimes.airTimeInMinutes, air)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    func testInitWithOutOffOnInTimes() {
        do {
            // Arrange
            let times = createFlightTimesArray()
            
            // Act
            let flightTimes = try FlightTimes(brakesReleased: times["brakesReleased"], takeoff: times["takeoff"], landing: times["landing"], brakesSet: times["brakesSet"])
            
            // Assert
            XCTAssertEqual(flightTimes.blockTimeInMinutes, 120) // 2 hours between 1200 and 1400
            XCTAssertEqual(flightTimes.airTimeInMinutes, 60) // 1 hour between 1230 and 1330
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    func testInitWithBlockAndAirTimesOutOfLimits() {
        XCTAssertThrowsError(try FlightTimes(block: 60, air: 120))
    }
    func testInitWithOutOffOnInTimesOutOfLimits() {
        XCTAssertThrowsError(try FlightTimes(brakesReleased: time(12, 00), takeoff: time(12, 30), landing: time(13, 00), brakesSet: time(12, 15)))
    }
    
    /* Value recalculation tests */
    func testChangingBrakesReleasedTimeRecalculateTotalTimesCorrectly () {
        // Arrange
        var flightTimes = createFlightTimes()
        
        // Act
        try? flightTimes.setTime(brakesReleased: time(11, 00))
        
        // Assert
        XCTAssertEqual(flightTimes.blockTimeInMinutes, 180) // 3 hours between 1100 and 1400
        XCTAssertEqual(flightTimes.airTimeInMinutes, 60) // 1 hour between 1230 and 1330
    }
    func testChangingTakeoffTimeRecalculateTotalTimesCorrectly () {
        // Arrange
        var flightTimes = createFlightTimes()
        
        // Act
        try? flightTimes.setTime(takeoff: time(13, 00))
        
        // Assert
        XCTAssertEqual(flightTimes.blockTimeInMinutes, 120) // 2 hours between 1200 and 1400
        XCTAssertEqual(flightTimes.airTimeInMinutes, 30) // 0.5 hour between 1300 and 1330
    }
    func testChangingLandingTimeRecalculateTotalTimesCorrectly () {
        // Arrange
        var flightTimes = createFlightTimes()
        
        // Act
        try? flightTimes.setTime(landing: time(14, 00))
        
        // Assert
        XCTAssertEqual(flightTimes.blockTimeInMinutes, 120) // 2 hours between 1200 and 1400
        XCTAssertEqual(flightTimes.airTimeInMinutes, 90) // 1.5 hours between 1230 and 1400
    }
    func testChangingBrakesSetTimeRecalculateTotalTimesCorrectly () {
        // Arrange
        var flightTimes = createFlightTimes()
        
        // Act
        try? flightTimes.setTime(brakesSet: time(15, 00))
        
        // Assert
        XCTAssertEqual(flightTimes.blockTimeInMinutes, 180) // 3 hours between 1200 and 1500
        XCTAssertEqual(flightTimes.airTimeInMinutes, 60) // 1 hour between 1230 and 1330
    }
    
    /* Value limit tests */
    func testTimesInIncorrectOrderThrowErrors() {
        // Arrange
        var flightTimes = createFlightTimes()
        
        // Act and assert
        XCTAssertThrowsError(try flightTimes.setTime(brakesReleased: time(13, 00))) // Brakes released after takeoff
        XCTAssertThrowsError(try flightTimes.setTime(brakesSet: time(13, 00))) // Brakes set before landing
        XCTAssertThrowsError(try flightTimes.setTime(takeoff: time(11, 00))) // Takeoff before brakes released
        XCTAssertThrowsError(try flightTimes.setTime(landing: time(15, 00))) // Landing after brakes set
    }

    /* Helper Tests */
    func testClockFormatWorksCorrectly() {
        // Arrange
        let flightTimes = createFlightTimes()
        
        // Assert
        XCTAssertEqual("2:00", flightTimes.blockTimeClockFormat)
        XCTAssertEqual("1:00", flightTimes.airTimeClockFormat)
    }
    
    /* Helpers */
    func createFlightTimes() -> FlightTimes {
        let times = createFlightTimesArray()
        return try! FlightTimes(brakesReleased: times["brakesReleased"], takeoff: times["takeoff"], landing: times["landing"], brakesSet: times["brakesSet"])
    }
    
    /// A helper to create Date objects to use in FlightTimes
    /// - Returns: [String: Date] Date objects for flight time testing
    func createFlightTimesArray() -> [String: Date] {
        return [
            "brakesReleased": time(12, 00),
            "takeoff": time(12, 30),
            "landing": time(13,30),
            "brakesSet": time(14,00)
        ]
    }
    
    /// Time helper
    /// - Parameters:
    ///   - hour: The hour to be set
    ///   - minute: The minute to be set
    /// - Returns: Date object with the hours and minute provided
    func time(_ hour: Int, _ minute: Int) -> Date {
        DateHelper.createDate(year: 2024, month: 01, day: 01, hour: hour, minute: minute)
    }
}
