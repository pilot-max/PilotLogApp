//
//  MileFraction.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-02-29.
//

import Foundation

struct MileFraction {
    let mileToFeet = 5280
    var distanceInFeet: CGFloat = 0
    var distanceInDecimal: CGFloat {
        get { CGFloat(distanceInFeet / 5280) }
        set { distanceInFeet = floor(newValue * 5280)}
    }
    
    var fraction: String {
        get {
            let whole = floor(distanceInDecimal)
            let decimal = distanceInDecimal - whole
            let wholeAsString = whole > 0 ? "\(Int(whole)) " : ""
            
            switch decimal {
                case 0.nextUp ... 1/8:
                    return "\(wholeAsString)1/8"
                case (1/8).nextUp ... 1/4:
                    return "\(wholeAsString)1/4"
                case (1/4).nextUp ... 3/8:
                    return "\(wholeAsString)3/8"
                case (3/8).nextUp ... 1/2:
                    return "\(wholeAsString)1/2"
                case (1/2).nextUp ... 5/8:
                    return "\(wholeAsString)5/8"
                case (5/8).nextUp ... 3/4:
                    return "\(wholeAsString)3/4"
                case (3/4).nextUp ... 7/8:
                    return "\(wholeAsString)7/8"
                case (7/8).nextUp ... 1:
                    return "\(Int(whole) + 1)"
                default:
                    return "\(Int(whole))"
                
                
            }
        }
        set {
            let explodedValue = newValue
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: " ")
            
            if explodedValue.count < 1 || explodedValue.count > 2 {
                // No value or too many values
                return
            }
            
            if explodedValue.count == 1 {
                // In case fraction is less than 1
                let defractionedValue = parseFraction(explodedValue[0])
                
                // Whole number or decimal
                distanceInDecimal = CGFloat(NSString(string: defractionedValue).floatValue)
                return
            }
            
            distanceInDecimal = stringToFloat(explodedValue[0]) + stringToFloat(parseFraction(explodedValue[1]))
            
            func parseFraction(_ fraction: String) -> String {
                let exploded = fraction
                    .components(separatedBy: "/")
                    .filter { $0 != "" }
                
                
                if exploded.count != 2 {
                    // Not a fraction
                    return fraction
                }
                
                return String(stringToFloat(exploded[0]) / stringToFloat(exploded[1]))
            }
        }
    }
    
    func stringToFloat(_ string: String) -> CGFloat {
        CGFloat(NSString(string: string).floatValue)
    }
    
    init(distanceInFraction: String) {
        self.fraction = distanceInFraction
    }
    
    init(distanceInFeet: CGFloat) {
        self.distanceInFeet = distanceInFeet
    }
    
    init(distanceInFeet: Int) {
        self.distanceInFeet = CGFloat(distanceInFeet)
    }
}

