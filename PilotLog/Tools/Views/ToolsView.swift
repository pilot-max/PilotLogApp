//
//  ToolsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI
import UserNotifications

struct ToolsView: View {
    var body: some View {
        NavigationView {
            HStack (spacing: 25) {
                // Crosswind Calculator
                NavigationLink {
                    CrosswindCalculatorView()
                } label: {
                    VStack {
                        Image(systemName: "wind")
                            .resizable()
                            .scaledToFit()
                            .padding(6)
                        Text("Crosswind Calculator")
                            .font(.headline)
                    }
                    .frame(width: 100, height: 100)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.foreground, lineWidth: 2)
                    )
                }
                
                // Approach Minima Calculator
                NavigationLink {
                    ApproachMinimumsCalculator()
                } label: {
                    VStack {
                        Image(systemName: "cloud.fog")
                            .resizable()
                            .scaledToFit()
                            .padding(6)
                        Text("Approach Minima")
                            .font(.headline)
                    }
                    .frame(width: 100, height: 100)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.foreground, lineWidth: 2)
                    )
                }
            }
            .foregroundStyle(.foreground)
            .navigationTitle("Tools")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ToolsView()
}
