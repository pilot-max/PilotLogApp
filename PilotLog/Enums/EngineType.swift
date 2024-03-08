//
//  EngineType.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-07.
//

import Foundation

enum EngineType: Codable {
    case piston
    case turboprop
    case turbofan
    case turbojet
    case rotaryTurboshaft
    case rotaryPiston
    
    var category: String {
        switch self {
        case .piston, .turboprop:
            return "propeller"
        case .turbofan, .turbojet:
            return "jet"
        case .rotaryPiston, .rotaryTurboshaft:
            return "helicopter"
        }
    }
    
    var isRotary: Bool {
        return self == .rotaryPiston || self == .rotaryTurboshaft
    }
}
