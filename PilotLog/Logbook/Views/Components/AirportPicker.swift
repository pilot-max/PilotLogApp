//
//  AirportPicker.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//

import SwiftData
import SwiftUI

struct AirportPicker: View {
//    @Environment(\.modelContext) private var context
//    @Query(sort: \Airport.ident) var airports: [Airport]
    var airports = Airport.factory(take: 50)
    
    var label: String
    
    @Binding var selection: String
    @State var selectedAirport: Airport?
    @State var isSearchFocused = true
    @State var isPresented: Bool = false
    @State var searchText = ""
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            if selectedAirport == nil {
                Text("Select \(label)")
            } else {
                //AirportLabel(selectedAirport!)
                Text("\(selectedAirport!.ident)")
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                if airports.count > 0 {
                    List {
                        ForEach(airports.filter {
                            $0.ident.hasPrefix(searchText.uppercased()) ||
                            $0.iata_code?.hasPrefix(searchText.uppercased()) ?? false ||
                            $0.name.range(of:searchText) != nil ||
                            $0.municipality.range(of:searchText) != nil
                        }) { airport in
                            Button {
                                selection = airport.ident
                                selectedAirport = airport
                                isPresented = false
                            } label: {
                                AirportLabel(airport)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("\(label)")
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                } else {
                    Text("No Airports Found")
                }
            }
        }
    }
    
    struct AirportLabel: View {
        var airport: Airport
        
        var body: some View {
            HStack {
                VStack {
                    Text("\(airport.ident)")
                    Text("\(airport.iata_code ?? "")")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(airport.name)")
                        .multilineTextAlignment(.trailing)
                    Text("\(airport.municipality), \(airport.iso_country)")
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
    return AirportPicker(label: "Departure", selection: $selection)
//        .modelContainer(for: Airport.self)
}
