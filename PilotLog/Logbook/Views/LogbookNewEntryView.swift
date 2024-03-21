//
//  LogbookNewEntryView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftUI

struct LogbookNewEntryView: View {
    @State var isShowingFlica = false
    @State var viewModel = ViewModel()
    
    var body: some View {
        // Use current time button
        // Show/hide fields
        
        NavigationStack {
            List {
                Section {
                    Grid {
                        GridRow {
                                Text("Departure")
                                Spacer()
                                Text("Arrival")
                        }
                        .font(.headline)
                        GridRow {
                            DatePicker("Departure Date", selection: $viewModel.departureDate, displayedComponents: .date)
                                .labelsHidden()
                            Spacer()
                            DatePicker("Departure Date", selection: $viewModel.departureDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        Divider()
                            .padding(.vertical)
                        GridRow {
                            VStack {
                                Text("Out")
                                DatePicker("Time out", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            VStack {
                                Text("Block")
                                Text("0:00")
                            }
                            VStack {
                                Text("Out")
                                DatePicker("Time in", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                        }
                        GridRow {
                            VStack {
                                Text("Off")
                                DatePicker("Time out", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            VStack {
                                Text("Air")
                                Text("0:00")
                            }
                            VStack {
                                Text("On")
                                DatePicker("Time in", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                        }
                    }
                    .padding()
                }
                
                Section("Route") {
                    AirportPicker(label: "Departure", selection: $viewModel.departureAirport)
                    AirportPicker(label: "Arrival", selection: $viewModel.arrivalAirport)
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
        .modelContainer(for: Airport.self)
}
