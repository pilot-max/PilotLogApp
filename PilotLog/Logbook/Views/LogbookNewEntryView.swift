//
//  LogbookNewEntryView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import SwiftUI

struct LogbookNewEntryView: View {
    @State var isShowingFlica = false
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
                        Text(viewModel.blockTime)
                    }
                    HStack {
                        Text("Air:")
                        Spacer()
                        Text("\(viewModel.airTime)")
                    }
                }
//                Section {
//                    Grid {
//                        GridRow {
//                                Text("Departure")
//                                Spacer()
//                                Text("Arrival")
//                        }
//                        .font(.headline)
//                        GridRow {
//                            DatePicker("Departure Date", selection: $viewModel.departureDate, displayedComponents: .date)
//                                .labelsHidden()
//                            Spacer()
//                            DatePicker("Arrival Date", selection: $viewModel.departureDate, displayedComponents: .date)
//                                .labelsHidden()
//                        }
//                        Divider()
//                            .padding(.vertical)
//                        GridRow {
//                            VStack {
//                                Text("Out")
//                                DatePicker("Time out", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
//                                    .labelsHidden()
//                            }
//                            VStack {
//                                Text("Block")
//                                Text("0:00")
//                            }
//                            VStack {
//                                Text("In")
//                                DatePicker("Time in", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
//                                    .labelsHidden()
//                            }
//                        }
//                        GridRow {
//                            VStack {
//                                Text("Off")
//                                DatePicker("Time out", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
//                                    .labelsHidden()
//                            }
//                            VStack {
//                                Text("Air")
//                                Text("0:00")
//                            }
//                            VStack {
//                                Text("On")
//                                DatePicker("Time in", selection: $viewModel.outTime, displayedComponents: .hourAndMinute)
//                                    .labelsHidden()
//                            }
//                        }
//                    }
//                    .padding()
//                }
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
