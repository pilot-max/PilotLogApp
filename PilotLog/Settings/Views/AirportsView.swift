//
//  AirportsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//

import ActivityIndicatorView
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
                    Text("\(airport.id ?? "") - \(airport.name ?? "No Name")")
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

#Preview {
    AirportsView()
        .environment(\.managedObjectContext, DataController.preview.container.viewContext)
}
