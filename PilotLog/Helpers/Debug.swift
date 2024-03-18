//
//  Debug.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import Foundation

struct Debug {
    static func log(_ message: String, caller: Any) {
        log("\(caller)\n- \(message)")
    }
    
    static func log(_ message: String) {
        if UserDefaults.standard.bool(forKey: "printDebugMessages") {
            print("\(message)")
        }
    }
}
