//
//  String.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-04-14.
//

import Foundation

extension String {
    var isOnlyDigits: Bool {
        let digits = CharacterSet.decimalDigits
        let stringSet = CharacterSet(charactersIn: self)
        
        return digits.isSuperset(of: stringSet)
    }
}
