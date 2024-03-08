//
//  AircraftTypeTests.swift
//  PilotLogTests
//
//  Created by Max Udaskin on 2024-03-07.
//

import XCTest
@testable import PilotLog

final class AircraftTypeTests: XCTestCase {
    func testInitializesCorrectly() {
        XCTAssertNoThrow(try createAircraftType())
    }
    
    func testEncodesAndDecodesCorrectly() {
        // Arrange
        let aircraft = try? createAircraftType()
        let jsonEncoder = JSONEncoder()
        let jsonDecoder = JSONDecoder()
        
        // Act
        let encodedAircraft: Data = try! jsonEncoder.encode(aircraft)
        let decodedAircraft = try! jsonDecoder.decode(AircraftType.self, from:encodedAircraft)

        // Assert
        XCTAssertEqual(aircraft, decodedAircraft)
    }
    
    func testEngineTypesCategorizeCorrectly() {
        // Arrange
        let piston = EngineType.piston
        let turboprop = EngineType.turboprop
        let turbojet = EngineType.turbojet
        let turbofan = EngineType.turbofan
        let rotaryTurboshaft = EngineType.rotaryTurboshaft
        let rotaryPiston = EngineType.rotaryPiston
        
        // Assert
        XCTAssertEqual("propeller", piston.category)
        XCTAssertEqual("propeller", turboprop.category)
        XCTAssertEqual("jet", turbojet.category)
        XCTAssertEqual("jet", turbofan.category)
        XCTAssertEqual("helicopter", rotaryPiston.category)
        XCTAssertEqual("helicopter", rotaryTurboshaft.category)
    }

    /* Helpers */
    func createAircraftType() throws -> AircraftType {
        AircraftType(manufacturer: "De Haviland", name: "DHC 8-400", icao: "DH8D", iata: "DH4", numberOfEngines: 2, engineType: .turboprop, isMultiCrew: true, isHighPerformance: true)
    }
}
