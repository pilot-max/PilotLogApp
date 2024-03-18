//
//  AirportsSettingsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import SwiftUI

struct AirportsSettingsView: View {
    @Binding var viewModel: SettingsView.ViewModel
    
    @State var showOnlySelectedCountries = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(
                    content: {
                        LabeledItem(label: "Minimum Runway Length (ft)") {
                            TextField("Minimum Runway Length in Feet", value: $viewModel.airportRunwayMinimumLength, formatter: NumberFormatter())
                        }
                        
                        LabeledItem(label: "Minimum Runway Width (ft)") {
                            TextField("Minimum Runway Width in Feet", value: $viewModel.airportRunwayMinimumWidth, formatter: NumberFormatter())
                        }
                        
                        Toggle("Scheduled Service Only", isOn: $viewModel.printDebugMessages)
                        
                        NavigationLink {
                            List {
                                ForEach(Continent.allCases, id: \.self.code) { continent in
                                    MultipleSelectionRow(title: continent.rawValue, isSelected: viewModel.airportDisplayContinents.contains(continent.code)) {
                                        if viewModel.airportDisplayContinents.contains(continent.code) {
                                            viewModel.airportDisplayContinents.removeAll(where: { $0 == continent.code })
                                        }
                                        else {
                                            viewModel.airportDisplayContinents.append(continent.code)
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
                                    if !showOnlySelectedCountries || viewModel.airportDisplayCountries.contains(key){
                                        MultipleSelectionRow(
                                            title: name,
                                            isSelected: viewModel.airportDisplayCountries.contains(key),
                                            isForceSelected: viewModel.airportDisplayContinents.contains(Countries.continent[key] ?? "")
                                        ) {
                                            if viewModel.airportDisplayCountries.contains(key) {
                                                viewModel.airportDisplayCountries.removeAll(where: { $0 == key })
                                            }
                                            else {
                                                viewModel.airportDisplayCountries.append(key)
                                            }
                                        }
                                    }
                                }
                                
                                if showOnlySelectedCountries {
                                    Section("Countries on selected Continents") {
                                        ForEach(Countries.name.sorted(by: <), id: \.key) { (key, name) in
                                            if viewModel.airportDisplayContinents.contains(Countries.continent[key] ?? "") &&
                                                !viewModel.airportDisplayCountries.contains(key){
                                                MultipleSelectionRow(
                                                    title: name,
                                                    isSelected: false,
                                                    isForceSelected: true
                                                ) {
                                                    viewModel.airportDisplayCountries.append(key)
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
    return AirportsSettingsView(viewModel: $vm)
}
