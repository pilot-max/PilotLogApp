//
//  AirportPicker.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//

import ActivityIndicatorView
import CoreData
import SwiftUI

struct AirportPicker: View {
    @Binding var selection: String
    var label: String
    
    @State var isSearchFocused = true
    @State var isPresented: Bool = false
    @State var airports: [Airport] = []
    @State var selectedAirport: Airport?
    @State var showAirportLoadingIndicator = false
    
    @Environment(\.managedObjectContext) var moc
    @State var searchText = ""
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\Airport.id)
        ]
    ) var fetchedAirports: FetchedResults<Airport>
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            if selectedAirport == nil {
                Text("Select \(label)")
            } else {
                AirportLabel(selectedAirport!)
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                if airports.count == 0 {
                    ActivityIndicatorView(isVisible: $showAirportLoadingIndicator, type: .scalingDots(count: 3))
                        .frame(width: 50.0, height: 50.0)
                        .foregroundColor(.gray)
                    
                    Text("Loading Airports")
                        .onAppear {
                            Task {
                                await loadAirports()
                            }
                            
                        }
                } else {
                    List {
                        ForEach(airports.filter {
                            $0.id?.hasPrefix(searchText.uppercased()) ?? false ||
                            $0.iata?.hasPrefix(searchText.uppercased()) ?? false ||
                            $0.name?.range(of:searchText) != nil ||
                            $0.city?.range(of:searchText) != nil
                        }) { airport in
                            Button {
                                selectedAirport = airport
                                selection = airport.id ?? ""
                                isPresented = false
                            } label: {
                                AirportLabel(airport)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("\(label)")
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                }
            }
        }
    }
    
    /// Load the airports into CoreData
    private func loadAirports() async {
        showAirportLoadingIndicator = true
        
        do {
            // Don't load the JSON multiple times
            if fetchedAirports.count == 0 {
                if let file = Bundle.main.url(forResource: "Airports", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
                    try decoder.decode([Airport].self, from: data)
                    try moc.save()
                }
            }
            
            self.airports = fetchedAirports.map { $0 }
            showAirportLoadingIndicator = false
        } catch {
            print("(AirportsView) \(error)")
        }
    }
    
    struct AirportLabel: View {
        var airport: Airport
        
        var body: some View {
            HStack {
                VStack {
                    Text("\(airport.id!)")
                    Text("\(airport.iata ?? "")")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(airport.name ?? "")")
                        .multilineTextAlignment(.trailing)
                    Text("\(airport.city ?? ""), \(airport.country ?? "")")
                        .font(.caption)
                }
            }
        }
        
        init(_ airport: Airport) {
            self.airport = airport
        }
    }
}

#Preview {
    @State var selection = ""
    
    return AirportPicker(selection: $selection, label: "Departure")
        .environment(\.managedObjectContext, DataController.preview.container.viewContext)
}
