//
//  Int.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-04-14.
//

import Foundation

extension Int {
    var clockTime: String {
        let hours = Int(self / 60)
        let minutes = Int(self - hours * 60)
        return "\(hours):\(String(format: "%02i", minutes))"
    }
}
