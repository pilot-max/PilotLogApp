//
//  AirportSettingsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftData
import SwiftUI

struct AirportSettingsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Airport.ident, order: .reverse) var airports: [Airport]
    
    var body: some View {
        NavigationStack {
            List {
                if airports.count > 0 {
                    ForEach(airports) { airport in
                        NavigationLink {
                            AirportView(airport: airport)
                        } label: {
                            Text("\(airport.ident): \(airport.name)")
                        }
                    }
                } else {
                    Text("No airports loaded.")
                    Button ("Load sample airports.") {
                        SampleAirports.list.forEach { airport in
                            context.insert(airport)
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    AirportSettingsView()
        .modelContainer(for: Airport.self)
}
