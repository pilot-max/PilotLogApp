//
//  FlightTimesTests.swift
//  PilotLogTests
//
//  Created by Max Udaskin on 2024-03-03.
//

import XCTest
@testable import PilotLog

final class FlightTimesTests: XCTestCase {

    func testBlockAndAirTimesInit() {
        // Arrange
        let block = 60
        let air = 60
        
        // Act
        let flightTimes = FlightTimes(block: block, air: air)
        
        // Assert
        XCTAssertEqual(flightTimes.blockTimeInMinutes, block)
        XCTAssertEqual(flightTimes.airTimeInMinutes, air)
    }

}
