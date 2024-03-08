//
//  Date.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-10-04.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: self)
    }
}
