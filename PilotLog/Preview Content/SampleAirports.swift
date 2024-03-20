//
//  SampleAirports.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

struct SampleAirports {
    static let list = [
        Airport(id: 1990, ident: "CYYZ", type: .large_airport, name: "Toronto Lester B. Pearson International Airport", latitude_deg: 43.6772, longitude_deg: -79.465599, continent: "NA", iso_country: "CA", iso_region: "CA-ON", municipality: "Toronto"),
        Airport(id: 1973, ident: "CYYC", type: .large_airport, name: "Calgary Interational Airport", latitude_deg: 51.113899231, longitude_deg: -114.019996643, continent: "NA", iso_country: "CA", iso_region: "CA-AB", municipality: "Calgary"),
        Airport(id: 1717, ident: "CYEG", type: .large_airport, name: "Edmonton International Airport", latitude_deg: 53.3097, longitude_deg: -113.580002, continent: "NA", iso_country: "CA", iso_region: "CA-AB", municipality: "Edmonton"),
        Airport(id: 1808, ident: "CYLW", type: .medium_airport, name: "Kelowna International Airport", latitude_deg: 49.9561, longitude_deg: -119.377998, continent: "NA", iso_country: "CA", iso_region: "CA-BC", municipality: "Kelowna")
    ]
}
