//
//  MenuButton.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct MenuButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}
