//
//  TimeFormatter.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-04-14.
//

import Foundation

class TimeFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        guard let minutes = obj as? Int,
                minutes >= 0,
                minutes <= 1440
        else { return nil }
        
        return "\(String(format: "%02d", minutes / 60)):\(String(format: "%02d", minutes % 60))"
    }
    
    override func getObjectValue(
        _ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
        for string: String,
        errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?
    ) -> Bool {
        
        let time = getTimeFromString(string)
        obj?.pointee = time as AnyObject
        return true
    }
    
    func getTimeFromString(_ string: String) -> Int {
        let separatedString = string.components(separatedBy: ":")
        
        // Time should be in 12:34 format
        if separatedString.count != 2 {
            return 0
        }
        
        // Time should contain only digits
        if !separatedString[0].isOnlyDigits, !separatedString[1].isOnlyDigits {
            // Time can only have digits
            return 0
        }
        guard let hours = Int(separatedString[0]),
              let minutes = Int(separatedString[1]),
              hours >= 0, hours < 24,
              minutes >= 0, minutes < 60 else {
            return 0
        }
        
        return (hours * 60) + minutes
    }
}
