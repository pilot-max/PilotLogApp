//
//  LogbookPreviewData.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-07.
//

import Foundation

struct LogbookPreviewData {
    //20277    1990    CYYZ    l    Toronto Lester B. Pearson International Airport    43.6772    -79.6306    569    NA    CA    CA-ON    Toronto    1    YYZ    YYZ    11120    200    1    0
    //20261    1973    CYYC    l    Calgary International Airport    51.113899231    -114.019996643    3557    NA    CA    CA-AB    Calgary    1    YYC        6200    150    1    0
    // 
    let airports = []
    
    let aircraft = [
        Aircraft(registration: "C-FNEN", tailNumber: "401", type: SampleAircraftTypes.dh8d.object(), airline: SampleAirlines.wen.object(), isActive: true),
        Aircraft(registration: "C-FHEN", tailNumber: "402", type: SampleAircraftTypes.dh8d.object(), airline: SampleAirlines.wen.object(), isActive: true),
        Aircraft(registration: "C-GJWE", tailNumber: "403", type: SampleAircraftTypes.dh8d.object(), airline: SampleAirlines.wen.object(), isActive: true)
    ]
        
    enum SampleAircraftTypes {
        case dh8d, b737, b738, b38m
        
        func object() -> AircraftType {
            switch self {
            case .dh8d:
                AircraftType(manufacturer: "DeHavilland", name: "DHC 8-400", icao: "DH8D", iata: "DH4", numberOfEngines: 2, engineType: .turboprop, isMultiCrew: true, isHighPerformance: true)
            case .b737:
                AircraftType(manufacturer: "Boeing", name: "737-700", icao: "B778", iata: "73W", numberOfEngines: 2, engineType: .turbofan, isMultiCrew: true, isHighPerformance: true)
            case .b738:
                AircraftType(manufacturer: "Boeing", name: "737-800", icao: "B738", iata: "73H", numberOfEngines: 2, engineType: .turbofan, isMultiCrew: true, isHighPerformance: true)
            case .b38m:
                AircraftType(manufacturer: "Boeing", name: "737 MAX8", icao: "B38M", iata: "7M8", numberOfEngines: 2, engineType: .turbofan, isMultiCrew: true, isHighPerformance: true)
            }
        }
    }

    enum SampleAirlines {
        case aca, wja, wen
        
        func object() -> Airline {
            switch self {
            case .aca: Airline(name: "Air Canada", icao: "ACA", iata: "AC", active: true, country: "CAN")
            case .wja: Airline(name: "WestJet", icao: "WJA", iata: "WS", active: true, country: "CAN")
            case .wen: Airline(name: "WestJet Encore", icao: "WEN", iata: "WR", active: true, country: "CAN")
            }
        }
    }
}

