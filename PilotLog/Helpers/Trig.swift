//
//  Trig.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-02-26.
//

import Foundation

func sin(degrees: Double) -> Double {
    return __sinpi(degrees/180.0)
}

func cos(degrees: Double) -> Double {
    return __cospi(degrees/180.0)
}

func tan(degrees: Double) -> Double {
    return tan(degrees * Double.pi / 180.0)
}

struct Trig {
    static func angle(opposite: CGFloat, hypotenuse: CGFloat) -> CGFloat {
        asin(opposite/hypotenuse) * 180 / Double.pi
    }
    
    static func angle(adjacent: CGFloat, hypotenuse: CGFloat) -> CGFloat {
        acos(adjacent/hypotenuse) * 180 / Double.pi
    }
    
    static func angle(opposite: CGFloat, adjacent: CGFloat) -> CGFloat {
        atan(opposite/adjacent) * 180 / Double.pi
    }
    
    static func opposite(angle: CGFloat, hypotenuse: CGFloat) -> CGFloat {
        sin(degrees: angle) * hypotenuse
    }
    
    static func opposite(angle: CGFloat, adjacent: CGFloat) -> CGFloat {
        tan(degrees: angle) * adjacent
    }
    
    static func adjacent(angle: CGFloat, hypotenuse: CGFloat) -> CGFloat {
        cos(degrees: angle) * hypotenuse
    }
    
    static func adjacent(angle: CGFloat, opposite: CGFloat) -> CGFloat {
        opposite / tan(degrees: angle)
    }
    
    static func hypotenuse(angle: CGFloat, opposite: CGFloat) -> CGFloat {
        opposite / sin(degrees: angle)
    }
    
    static func hypotenuse(angle: CGFloat, adjacent: CGFloat) -> CGFloat {
        adjacent / cos(degrees: angle)
    }
}
