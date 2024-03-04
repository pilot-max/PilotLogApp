//
//  ApproachLightingTypes.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-02-26.
//

import Foundation

enum ApproachLighting: String, Identifiable, CaseIterable {
    case aslf1 = "ASLF-I"
    case alsf2 = "ALSF-II"
    case calvert = "CALVERT"
    case calvert2 = "CALVERT2"
    case mals  = "MALS"
    case malsf = "MALSF"
    case malsr = "MALSR"
    case odals = "ODALS"
    case rail  = "RAIL"
    case sals  = "SALS"
    case ssal  = "SSAL"
    case ssalf = "SSALF"
    case ssalr = "SSALR"
    case none = "No Approach Lighting"
    
    
    func length(slope: CGFloat = 3.0) -> Int {
        switch self {
        case .mals, .malsf, .ssal, .ssalf:
            return 1400
        case .odals, .sals:
            return 1500
        case .calvert, .calvert2:
            return 1650
        case .malsr:
            return 2400
        case .aslf1,
                .alsf2,
                .ssalr:
            if slope <= 2.75 {
                return 3000
            }
            return 2400
        case .rail, .none:
            return 0
        }
    }
    
    var id: Self { self }
}
