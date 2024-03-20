//
//  Debug.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import Foundation

struct Debug {
    static func error(_ error: Error, caller: Any? = nil) {
        print("\(Date()): \(caller ?? "")\n\(error) :: \(error.localizedDescription)")
    }
}
