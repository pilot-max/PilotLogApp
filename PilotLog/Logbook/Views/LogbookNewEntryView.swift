//
//  LogbookNewEntryView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftUI

struct LogbookNewEntryView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        // Use current time button
        // Show/hide fields
        
        NavigationStack {
            List {
                Section {
                    DatePicker("Departure Date", selection: $viewModel.flightTimes.departureDate, displayedComponents: .date)
                    Text("Aircraft:")
                }
                
                Section("Route") {
                    AirportPicker(label: "Departure Aerodrome", selection: $viewModel.departureAirport)
                    AirportPicker(label: "Arrival Aerodrome", selection: $viewModel.arrivalAirport)
                }
                
                Section("Times") {
                    DatePicker("Out", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
                    DatePicker("Takeoff", selection: $viewModel.offTime, displayedComponents: .hourAndMinute)
                    DatePicker("Landing", selection: $viewModel.onTime, displayedComponents: .hourAndMinute)
                    DatePicker("In", selection: $viewModel.inTime, displayedComponents: .hourAndMinute)
                }
                .environment(\.locale, .init(identifier: "de"))
                .environment(\.timeZone, .gmt)
                
                Section {
                    HStack {
                        Text("Block:")
                        Spacer()
                        Text(viewModel.flightTimes.blockTimeClockFormat)
                    }
                    HStack {
                        Text("Air:")
                        Spacer()
                        Text("\(viewModel.flightTimes.airTimeClockFormat)")
                    }
                }
            }
            .navigationTitle("Add Flight")
            .toolbar {
                Button {
                    print("ToDo: Save Flight.")
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    LogbookNewEntryView()
//        .modelContainer(for: Airport.self)
}
