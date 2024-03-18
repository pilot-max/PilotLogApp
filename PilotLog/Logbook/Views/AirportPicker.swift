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
    @State var selectedAirport: Airport?
    @State var showAirportLoadingIndicator = false
    @State var searchText = ""
    
    var airports: [Airport]
    
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
    let vm = LogbookView.ViewModel()
    return AirportPicker(selection: $selection, label: "Departure", airports: vm.airports)
}
