//
//  DutyType.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-15.
//

import Foundation

enum DutyType: String {
    case flight = "Flight"
    case sim = "Simulator"
    case deadhead = "Deadhead"
    
    static func isValid(_ rawValue: String) -> Bool {
       return DutyType(rawValue: rawValue) != nil
    }
}
