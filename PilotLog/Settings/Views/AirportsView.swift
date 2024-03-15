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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\Airport.id)
        ]
    ) var airports: FetchedResults<Airport>
    
    @State var showAirportLoadingIndicator = true
    
    var body: some View {
        
        if airports.count == 0 {
            ActivityIndicatorView(isVisible: $showAirportLoadingIndicator, type: .scalingDots(count: 3))
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.gray)
                .onAppear {
                    Task {
                        await loadAirports()
                    }
                }
            Text("Loading Airports")
        } else {
            List {
                ForEach(airports) { airport in
                    NavigationLink {
                        AirportDetailView(airport: airport)
                    } label: {
                        VStack {
                            HStack {
                                Text("\(airport.id!)")
                                Spacer()
                                Text("\(airport.name ?? "")")
                            }
                            HStack {
                                Text("\(airport.iata ?? "")")
                                Spacer()
                                Text("\(airport.city ?? ""), \(airport.country ?? "")")
                            }
                            .font(.caption)
                        }
                    }
                }
            }
        }
    }
    
    /// Load the airports into CoreData
    private func loadAirports() async {
        showAirportLoadingIndicator = true
        
        do {
            if let file = Bundle.main.url(forResource: "Airports", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
                try decoder.decode([Airport].self, from: data)
                try moc.save()
                
                showAirportLoadingIndicator = false
            }
        } catch {
            print("(AirportsView) \(error)")
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
                center: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        )
    }

    var body: some View {
        List {
            Text("ICAO: \(airport.id ?? "")")
            Text("IATA: \(airport.iata ?? "N/A")")
            Text("Location: \(airport.city ?? ""), \(airport.country ?? "")")
            Text("Latt/Long: \(airport.latitude)/\(airport.longitude)")
            Text("Altitude: \(airport.altitude)")
            Text("Timezone: \(airport.timezone ?? "")")
        }
        .navigationTitle(airport.name ?? "\(airport.id!) Airport Details")
        
        Map(initialPosition: position, interactionModes: []) {
            Marker(airport.name ?? airport.id!, coordinate: CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude))
        }
        .mapStyle(.standard)
    }
}

#Preview {
    NavigationView {
        AirportsView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
    }
}
