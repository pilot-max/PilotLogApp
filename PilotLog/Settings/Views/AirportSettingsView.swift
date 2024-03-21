//
//  AirportSettingsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftData
import SwiftUI

struct AirportSettingsView: View {
//    @Environment(\.modelContext) private var context
//    @Query(sort: \Airport.ident) var airports: [Airport]
    var airports = Airport.factory(take: 10)
    
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
                }
            }
        }
    }
    
}

#Preview {
    AirportSettingsView()
}
