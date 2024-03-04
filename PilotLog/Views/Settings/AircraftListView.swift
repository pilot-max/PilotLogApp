//
//  AircraftListView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct AircraftListView: View {
    var body: some View {
        List {
            ForEach(["C-FNEN", "C-FHEN", "C-GJWE"], id: \.self) { aircraft in
                Text(aircraft)
            }
        }
        .navigationTitle("Aircraft")
    }
}

#Preview {
    AircraftListView()
}
