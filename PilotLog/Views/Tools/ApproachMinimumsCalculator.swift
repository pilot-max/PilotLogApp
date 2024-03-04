//
//  ApproachMinimumsCalculator.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-02-25.
//

import SwiftUI

struct ApproachMinimumsCalculator: View {
    @State private var approachAngle: CGFloat = 3.0
    @State private var approachLighting: ApproachLighting = .none
    @State private var ceilingHeightInFeet: CGFloat = 1000
    @State private var visibility = MileFraction(distanceInFraction: "3")
    @State private var minimumDescentAltitude: CGFloat = 200
    
    @State private var bandaidBindingString = ""
    
    var firstContact: [String] {
        // Ceiling cannot be lower than the minimums
        if ceilingHeightInFeet < minimumDescentAltitude {
            return [
                "You will likely not make contact before minimums.",
                "The ceiling is lower than minimums."
            ]
        }
        
        // Contact height from visibility (slant distance) cannot be lower than the minimums
        var approachLightingFactoredIn = false
        var firstContactHeightFromVisibility = Trig.opposite( angle: approachAngle, adjacent: visibility.distanceInFeet)
        if firstContactHeightFromVisibility < minimumDescentAltitude {
            firstContactHeightFromVisibility = Trig.opposite(angle: approachAngle,
                adjacent: visibility.distanceInFeet + CGFloat(approachLighting.length(slope: approachAngle)))
            
            if firstContactHeightFromVisibility < minimumDescentAltitude {
                return [
                    "You will likely not make contact before minimums.",
                    "The visibility too low."
                ]
            }
            
            // Approach lights made the difference
            approachLightingFactoredIn = true
        }
        
        // First contact is at the lower of the two altitudes
        let firstContactHeight = min(firstContactHeightFromVisibility, ceilingHeightInFeet)
        let firstContactDistance = MileFraction(distanceInFeet: Trig.adjacent(angle: approachAngle, opposite: firstContactHeight)).fraction
        let firstContactObject = approachLightingFactoredIn ? "approach lights" : "runway"
        
        return [
            "You should see the \(firstContactObject)",
            "\(firstContactDistance) miles from the threshold",
            "at \(Int(firstContactHeight))' HAT."
        ]
    }
    
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        return formatter
    }()
    
    let integerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumIntegerDigits = 1
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // Calculated Answers
                VStack {
                    ForEach(firstContact, id: \.self) { line in
                        Text(line)
                    }
                }
                .font(.headline)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack {
                    HStack(alignment: .top) {
                        VStack {
                            Picker(selection: $approachLighting) {
                                ForEach(ApproachLighting.allCases) { type in
                                    Text(type.rawValue)
                                }
                                .padding(10)
                                .frame(width: 200, alignment: .leading)
                            } label: {
                                Text("Approach Lighting")
                                    .foregroundStyle(.foreground)
                            }
                            .pickerStyle(.navigationLink)
                        }
                    }
                    
                    VStack {
                        // Approach Angle
                        StepperNumber(label: "Approach Angle", value: $approachAngle, formatter: decimalFormatter, range: 2...6, step: 0.1)
                        
                        // Minimums
                        StepperNumber(label: "Minimums",  value: $minimumDescentAltitude, formatter: integerFormatter, range: 0...1000, step: 50)
                        
                        // Visibility
                        StepperString(label: "Visibility (SM)", string: $visibility.fraction, value: $visibility.distanceInFeet, range: 0...(5280 * 6), step: 660)
                        
                        // Ceiling
                        StepperNumber(label: "Ceiling (HAT)", value: $ceilingHeightInFeet, formatter: integerFormatter, range: 0...3000, step: 100)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    ApproachMinimumsCalculator()
}
