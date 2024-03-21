//
//  AircraftView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-20.
//

//import SwiftData
import SwiftUI

struct AircraftView: View {
//    @Environment(\.modelContext) private var context
//    @Query(sort: [
//        SortDescriptor(\Aircraft.tailNumber),
//        SortDescriptor(\Aircraft.registration)]) var aircrafts: [Aircraft] // Forgive me for the improper plural. It's for clarity.
    var aircrafts = Aircraft.factory(take: 10)
    
    var body: some View {
        NavigationStack {
            if aircrafts.count == 0 {
                Text("No aircraft found.")
                Button("Load sample aircraft.") {
//                    LogbookPreviewData().aircraft.forEach { aircraft in
//                        //let newAircraft = Aircraft(registration: aircraft.registration, type: aircraft.type, airline: aircraft.airline)
//                        //context.insert(Aircraft(registration: "ABCDE", type: LogbookPreviewData.SampleAircraftTypes.dh8d.object()))
//                    }
                }
                .navigationTitle("Aircraft")
            } else {
                List {
                    ForEach(aircrafts) { aircraft in
                        Text("\(aircraft.registration)")
                    }
                }
                .navigationTitle("Aircraft")
            }
        }
    }
}

#Preview {
    AircraftView()
//        .modelContainer(for: [
//            Aircraft.self,
//            AircraftType.self
//        ])
}
