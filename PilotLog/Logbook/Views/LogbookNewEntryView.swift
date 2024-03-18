//
//  LogbookNewEntryView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-12.
//

import ActivityIndicatorView
import SwiftUI

struct LogbookNewEntryView: View {
    var viewModel: LogbookView.ViewModel
//    @FetchRequest(
//        sortDescriptors: [
//            SortDescriptor(\Airport.id)
//        ]
//    ) var airports: FetchedResults<Airport>
    
    @State var date = Date()
    @State var dutyType = "Flight"
    @State var departure = ""
    @State var arrival = ""
    @State var timeOut = Date()
    @State var timeOff = Date()
    @State var timeOn = Date()
    @State var timeIn = Date()
    @State var scheduledTimeOut = Date()
    @State var scheduledTimeOff = Date()
    @State var scheduledTimeOn = Date()
    @State var scheduledTimeIn = Date()
    
    @State private var showingDepartureAirportSelector = false
    @State private var showingArrivalAirportSelector = false
    @State private var showingScheduledTimes: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("") {
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                    Picker("Duty Type", selection: $dutyType) {
                        Text("Flight")
                        Text("Simulator")
                        Text("Deadhead")
                    }
                }
                
                Section("Departure") {
                    AirportPicker(selection: $departure, label: "Departure", airports: viewModel.airports)
                }
            
                Section("Arrival") {
                    AirportPicker(selection: $arrival, label: "Arrival", airports: viewModel.airports)
                }
                
                Section("Actual Times") {
                    HStack(spacing: 25){
                        TimePicker(label: "Out", selection: $timeOut)
                        TimePicker(label: "In", selection: $timeIn)
                    }
                    
                    HStack(spacing: 25){
                        TimePicker(label: "Off", selection: $timeOff)
                        TimePicker(label: "On", selection: $timeOn)
                    }
                    
                    HStack {
                        Text("Block Time:")
                        Spacer()
                        Text("0.0")
                    }
                    HStack {
                        Text("Air Time:")
                        Spacer()
                        Text("0.0")
                    }
                }
                
                if showingScheduledTimes {
                    Section("Scheduled Times") {
                        HStack(spacing: 25){
                            TimePicker(label: "Out", selection: $scheduledTimeOut)
                            TimePicker(label: "In", selection: $scheduledTimeIn)
                        }
                        
                        HStack(spacing: 25){
                            TimePicker(label: "Off", selection: $scheduledTimeOff)
                            TimePicker(label: "On", selection: $scheduledTimeOn)
                        }
                        
                        HStack {
                            Text("Block Time:")
                            Spacer()
                            Text("0.0")
                        }
                        HStack {
                            Text("Air Time:")
                            Spacer()
                            Text("0.0")
                        }
                        Button("Hide") {
                            showingScheduledTimes = false
                        }
                    }
                } else {
                    Text("Scheduled Times")
                        .onTapGesture {
                        showingScheduledTimes = true
                    }
                }
            }
            .navigationTitle("New Entry")
        }
    }
}

struct TimePicker: View {
    var label: String
    var selection: Binding<Date>
    var timezone: TimeZone = TimeZone(secondsFromGMT: 0)!
    
    var body: some View {
        DatePicker(label, selection: selection, displayedComponents: [.hourAndMinute])
            .environment(\.timeZone, timezone)
            .environment(\.locale, Locale.init(identifier: "gb"))

    }
}

struct BindingDate: Identifiable {
    var id: String
    var value: Binding<Date>
    
    static func date(label: String, selection: Binding<Date>) -> BindingDate {
        self.init(id: label, value: selection)
    }
}
#Preview {
    LogbookNewEntryView(viewModel: LogbookView.ViewModel())
}
