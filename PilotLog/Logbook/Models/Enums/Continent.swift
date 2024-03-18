//
//  Continent.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import Foundation

enum Continent: String, CaseIterable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northamerica = "North America"
    case oceania = "Oceania"
    case southamerica = "South America"
    
    var code: String {
        switch self {
        case .africa:
            return "AF"
        case .antarctica:
            return "AN"
        case .asia:
            return "AS"
        case .europe:
            return "EU"
        case .northamerica:
            return "NA"
        case .oceania:
            return "OC"
        case .southamerica:
            return "SA"
        }
    }
    
    func from(code: String) -> Continent {
        switch code {
        case "AF":
            return .africa
        case "AN":
            return .antarctica
        case "AS":
            return .asia
        case "EU":
            return .europe
        case "NA":
            return .northamerica
        case "OC":
            return .oceania
        case "SA":
            return .southamerica
        default:
            return .antarctica
        }
    }
}
