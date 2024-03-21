//
//  AirportView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

import MapKit
import SwiftUI

struct AirportView: View {
    let airport: Airport
    let centeredOn: CLLocationCoordinate2D
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Name:")
                    Spacer()
                    Text("\(airport.name)").multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Identifier:")
                    Spacer()
                    Text("\(airport.ident)").multilineTextAlignment(.trailing)
                }
            }
            Map(initialPosition: MapCameraPosition.region(MKCoordinateRegion(
                    center: centeredOn,
                    span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                ))) {
                Marker(airport.name, coordinate: centeredOn)
            }
        }
    }
    
    init(airport: Airport) {
        self.airport = airport
        self.centeredOn = CLLocationCoordinate2D(latitude: airport.latitude_deg, longitude: airport.longitude_deg)
        
    }
}

#Preview {
    AirportSettingsView()
//        .modelContainer(for: Airport.self)
}
