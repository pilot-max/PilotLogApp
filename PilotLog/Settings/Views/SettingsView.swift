//
//  SettingsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct SettingsView: View {
    @State var viewModel = ViewModel()
    
    var aircraft = LogbookPreviewData().aircraft
    
    var body: some View {
        NavigationStack {
            Form {
                Section (header: Text("Lists")){
                    NavigationLink {
                        AircraftListView(aircraft: aircraft)
                    } label: {
                        Text("Aircraft")
                    }
                    
                    NavigationLink {
                        // AirportsView()
                        AirportsSettingsView(viewModel: $viewModel)
                    } label: {
                        Text("Airports")
                    }
                    
                    NavigationLink {
                        Text("Test")
                    } label: {
                        Text("Pilots")
                    }
                }
                
                Section("Debug") {
                    Toggle("Print Debug Messages to Log", isOn: $viewModel.printDebugMessages)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct LabeledItem<Content: View>: View {
    let label: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label)")
                .font(.caption)
                .foregroundStyle(.primary)
            content
        }
    }
}

#Preview {
    SettingsView()
        .environment(\.managedObjectContext, DataController.preview.container.viewContext)
}
