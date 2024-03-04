//
//  CrosswindCalculatorView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct CrosswindCalculatorView: View {
    @State private var runwayHeading = CGFloat(0)
    @State private var windDirection = CGFloat(0)
    @State private var windSpeed = CGFloat(0)
    
    @State private var bandaidBindingString = ""
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 3
        return formatter
    }()
    
    var body: some View {
        var crosswindAngle: Double {
            abs(windDirection - runwayHeading)
        }
        var crosswindDirectionString: String {
            if crosswindAngle == 0 {
                return "on the nose"
            }
            if crosswindAngle == 180 {
                return "on the tail"
            }
            if crosswindAngle > 0 && crosswindAngle < 180 {
                return "from the right"
            }
            return "from the left"
        }
        var crosswindSpeedString: String {
            let crosswind = Int(abs(round(sin(degrees: crosswindAngle) * windSpeed)))
            return "Crosswind: \(crosswind) knots"
        }
        var headwindSpeedString: String {
            let headwind = Int(round(cos(degrees: crosswindAngle) * windSpeed))
            let prefix = headwind < 0 ? "Tailwind" : "Headwind"
            return "\(prefix): \(headwind) knots"
        }
        
        NavigationView {
            VStack {
                Text("Crosswind Angle: \(Int(crosswindAngle))° \(crosswindDirectionString)")
                Text(headwindSpeedString)
                Text(crosswindSpeedString)
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.accentColor, lineWidth: 5)
                        .frame(width: 250, height: 250)
                    
                    drawWindDirection()
                    drawAirplane()
                }
                Spacer()
                
                VStack {
                    StepperNumber(label: "Runway Heading", value: $runwayHeading, formatter: formatter, range: 0...359, step: 1)
                    
                    StepperNumber(label: "Wind Direction", value: $windDirection, formatter: formatter, range: 0...359, step: 1)
                    
                    StepperNumber(label: "Wind Speed", value: $windSpeed, formatter: formatter, range: 0...100, step: 1)
                }
            }
            .padding()
            .navigationTitle("Crosswind Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func drawAirplane() -> some View {
        var rotationAngle = runwayHeading - 90
        if rotationAngle > 360 {
            rotationAngle -= 360
        }
        
        return Image(systemName: "airplane")
            .font(.largeTitle)
            .rotationEffect(.degrees(Double(rotationAngle)))
    }
    
    func drawWindDirection() -> some View {
        var body: some View {
            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(180))
                .offset(y: -110)
                .rotationEffect(.degrees(windDirection))
        }
        
        return body
    }
}
#Preview {
    CrosswindCalculatorView()
}
