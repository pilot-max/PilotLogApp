//
//  AircraftListView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct AircraftListView: View {
    var aircraft: [Aircraft]
    var body: some View {
        List {
            ForEach(aircraft) { airplane in
                AircraftListViewItem(aircraft: airplane)
            }
        }
        .navigationTitle("Aircraft")
    }
}

struct AircraftListViewItem: View {
    let aircraft: Aircraft
    
    var body: some View {
        VStack {
            HStack {
                Text(aircraft.registration)
                if let tailNumber = aircraft.tailNumber {
                    Text("(\(tailNumber))")
                        .font(.caption)
                }
            }
            .padding(.bottom, 6)
            HStack {
                Text(aircraft.airline.name)
                Spacer()
                Text(aircraft.type.manufacturer)
                Text(aircraft.type.name)
            }
            .font(.caption2)
        }
    }
}

#Preview {
    AircraftListView(aircraft: LogbookPreviewData().aircraft)
}
