//
//  AirportsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//

import ActivityIndicatorView
import MapKit
import SwiftUI

struct AirportsView: View {
    @State var viewModel: AirportsSettingsView.ViewModel
    @State var showAirportLoadingIndicator = true
    
    var body: some View {
        
        if viewModel.airports.array.count == 0 {
            VStack {
                ActivityIndicatorView(isVisible: $showAirportLoadingIndicator, type: .scalingDots(count: 3))
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(.gray)
                Text("Loading Airports")
                
                Button("Load Airports from File") {
                    viewModel.airports.loadAirportsFromFile()
                    viewModel.airports.fetchAirports()
                    showAirportLoadingIndicator = true
                }
                .padding()
            }
        } else {
            List {
                ForEach(viewModel.airports.array) { airport in
                    NavigationLink {
                        AirportDetailView(airport: airport)
                    } label: {
                        VStack {
                            HStack {
                                Text("\(airport.ident ?? "?")")
                                Spacer()
                                Text("\(airport.name ?? "")")
                            }
                            HStack {
                                Text("\(airport.iata_code ?? "")")
                                Spacer()
                                Text("\(airport.municipality ?? ""), \(airport.iso_country ?? "")")
                            }
                            .font(.caption)
                        }
                    }
                }
            }
        }
    }
}

struct AirportDetailView: View {
    var airport: Airport
    let position: MapCameraPosition
    
    init(airport: Airport) {
        self.airport = airport
        self.position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: airport.latitude_deg, longitude: airport.longitude_deg),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        )
    }

    var body: some View {
        List {
            Text("DB ID: \(airport.id)")
            Text("ICAO: \(airport.ident ?? "")")
            Text("IATA: \(airport.iata_code ?? "N/A")")
            Text("Location: \(airport.municipality ?? ""), \(airport.iso_country ?? "")")
            Text("Latt/Long: \(airport.latitude_deg)/\(airport.longitude_deg)")
            Text("Altitude: \(airport.elevation_ft)")
            //Text("Timezone: \(airport.timezone ?? "")")
        }
        .navigationTitle(airport.name ?? "\(airport.ident!) Airport Details")
        
        Map(initialPosition: position, interactionModes: []) {
            Marker(airport.name ?? airport.ident!, coordinate: CLLocationCoordinate2D(latitude: airport.latitude_deg, longitude: airport.longitude_deg))
        }
        .mapStyle(.standard)
    }
}

#Preview {
    NavigationView {
        AirportsView(viewModel: AirportsSettingsView.ViewModel())
    }
}
