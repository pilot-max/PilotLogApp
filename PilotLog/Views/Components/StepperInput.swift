//
//  StepperInput.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-02-29.
//

/**
To do:
    StepperInput should be StepperString and StepperNumber
        StepperNumber should have a numeric pad instead of text
 */

import SwiftUI

struct StepperNumber: View {
    let label: String
    @Binding var value: CGFloat
    let formatter: NumberFormatter?
    let range: ClosedRange<CGFloat>?
    let step: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                StepperTextField(TextField(label, value: $value, formatter: formatter!))
                StepperButtons(value: $value, step: step, range: range)
            }
        }
    }
}

struct StepperString: View {
    let label: String
    @Binding var string: String
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>?
    let step: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                StepperTextField(TextField(label, text: $string))
                StepperButtons(value: $value, step: step, range: range)
            }
        }
    }
}

struct StepperTextField: View {
    let textField: TextField<Text>
    
    var body: some View {
        textField
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.accent, lineWidth: 1)
            )
            .frame(width: 175, alignment: .trailing)
    }
    
    init(_ textField: TextField<Text>) {
        self.textField = textField
    }
}

struct StepperButtons: View {
    @Binding var value: CGFloat
    var step: CGFloat
    var range: ClosedRange<CGFloat>?
    
    var body: some View {
        VStack {
            Button {
                if ((range?.contains(value + step)) != nil) {
                    value += step
                }
            } label: {
                Image(systemName: "arrowtriangle.up.square")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
            }
            Button {
                if ((range?.contains(value - step)) != nil) {
                    value -= step
                }
            } label: {
                Image(systemName: "arrowtriangle.down.square")
            }
        }
    }
}
