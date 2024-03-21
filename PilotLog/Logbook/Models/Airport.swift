//
//  Airport.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation
//import SwiftData

//@Model
final class Airport: Identifiable {
//    @Attribute(.unique) var id: Int
//    @Attribute(.unique) var ident: String
    var id: Int
    var ident: String
    var type: AirportType
    var name: String
    var latitude_deg: Double
    var longitude_deg: Double
    var elevation_ft: Int
    var continent: String
    var iso_country: String
    var iso_region: String
    var municipality: String
    var scheduled_service: Bool
    var gps_code: String?
    var iata_code: String?
    var local_code: String?
    var runway_length_ft: Int
    var runway_width_ft: Int
    var runway_lighted: Bool
    
    init(id: Int,
         ident: String,
         type: AirportType,
         name: String,
         latitude_deg: Double,
         longitude_deg: Double,
         elevation_ft: Int = 0,
         continent: String,
         iso_country: String,
         iso_region: String, municipality: String,
         scheduled_service: Bool = false,
         gps_code: String? = nil,
         iata_code: String? = nil,
         local_code: String? = nil,
         runway_length_ft: Int = 0,
         runway_width_ft: Int = 0,
         runway_lighted: Bool = false) {
        self.id = id
        self.ident = ident
        self.type = type
        self.name = name
        self.latitude_deg = latitude_deg
        self.longitude_deg = longitude_deg
        self.elevation_ft = elevation_ft
        self.continent = continent
        self.iso_country = iso_country
        self.iso_region = iso_region
        self.municipality = municipality
        self.scheduled_service = scheduled_service
        self.gps_code = gps_code
        self.iata_code = iata_code
        self.local_code = local_code
        self.runway_length_ft = runway_length_ft
        self.runway_width_ft = runway_width_ft
        self.runway_lighted = runway_lighted
    }
}
