//
//  UserDefaults.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import Foundation

extension UserDefaults {
    
    func setIfNew(_ value: Any?, forKey key: String) {
        if object(forKey: key) == nil {
            UserDefaults.standard.set(value, forKey: key)
        }
    }
}
