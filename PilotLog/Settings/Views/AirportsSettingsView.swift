//
//  AirportsSettingsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import SwiftUI

struct AirportsSettingsView: View {
    @Binding var settingsViewModel: SettingsView.ViewModel
    @State var viewModel = AirportsSettingsView.ViewModel()
    
    @State var showOnlySelectedCountries = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Loaded Airports") {
                    NavigationLink("Loaded Airports") {
                        AirportsView(viewModel: viewModel)
                    }
                }
                Section(
                    content: {
                        LabeledItem(label: "Minimum Runway Length (ft)") {
                            TextField("Minimum Runway Length in Feet", value: $settingsViewModel.airportRunwayMinimumLength, formatter: NumberFormatter())
                        }
                        
                        LabeledItem(label: "Minimum Runway Width (ft)") {
                            TextField("Minimum Runway Width in Feet", value: $settingsViewModel.airportRunwayMinimumWidth, formatter: NumberFormatter())
                        }
                        
                        Toggle("Scheduled Service Only", isOn: $settingsViewModel.printDebugMessages)
                        
                        NavigationLink {
                            List {
                                ForEach(Continent.allCases, id: \.self.code) { continent in
                                    MultipleSelectionRow(title: continent.rawValue, isSelected: settingsViewModel.airportDisplayContinents.contains(continent.code)) {
                                        if settingsViewModel.airportDisplayContinents.contains(continent.code) {
                                            settingsViewModel.airportDisplayContinents.removeAll(where: { $0 == continent.code })
                                        }
                                        else {
                                            settingsViewModel.airportDisplayContinents.append(continent.code)
                                        }
                                    }
                                }
                            }
                        } label: {
                            Text("Continents")
                        }
                        
                        NavigationLink {
                            List {
                                ForEach(Countries.name.sorted(by: <), id: \.key) { (key, name) in
                                    if !showOnlySelectedCountries || settingsViewModel.airportDisplayCountries.contains(key){
                                        MultipleSelectionRow(
                                            title: name,
                                            isSelected: settingsViewModel.airportDisplayCountries.contains(key),
                                            isForceSelected: settingsViewModel.airportDisplayContinents.contains(Countries.continent[key] ?? "")
                                        ) {
                                            if settingsViewModel.airportDisplayCountries.contains(key) {
                                                settingsViewModel.airportDisplayCountries.removeAll(where: { $0 == key })
                                            }
                                            else {
                                                settingsViewModel.airportDisplayCountries.append(key)
                                            }
                                        }
                                    }
                                }
                                
                                if showOnlySelectedCountries {
                                    Section("Countries on selected Continents") {
                                        ForEach(Countries.name.sorted(by: <), id: \.key) { (key, name) in
                                            if settingsViewModel.airportDisplayContinents.contains(Countries.continent[key] ?? "") &&
                                                !settingsViewModel.airportDisplayCountries.contains(key){
                                                MultipleSelectionRow(
                                                    title: name,
                                                    isSelected: false,
                                                    isForceSelected: true
                                                ) {
                                                    settingsViewModel.airportDisplayCountries.append(key)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .toolbar {
                                Button {
                                    showOnlySelectedCountries.toggle()
                                } label: {
                                    HStack {
                                        if showOnlySelectedCountries {
                                            Text("Show All Countries")
                                        } else {
                                            Text("Show Selected Countries")
                                        }
                                    }
                                }
                            }
                        } label: {
                            Text("Countries")
                        }
                    }, header: {
                        Text("Filters")
                    }, footer: {
                        Text("Filters will limit the numbers of airports shown and will provide a performance increase.")
                    })
            }
            .navigationTitle("Airports")
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var isForceSelected: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark").foregroundColor(.blue)
                } else if self.isForceSelected {
                    Spacer()
                    Image(systemName: "asterisk").foregroundColor(.gray)
                }
            }
        }.foregroundColor(Color.black)
    }
}

#Preview {
    @State var vm = SettingsView.ViewModel()
    return AirportsSettingsView(settingsViewModel: $vm)
}
