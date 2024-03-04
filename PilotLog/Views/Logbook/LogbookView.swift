//
//  LogbookView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct LogbookView: View {
    let entry = LogbookEntry(id: UUID(), times: FlightTimes(block: 60, air: 45))
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Entry \(entry.id) Block: \(entry.times.blockTimeClockFormat) Air: \(entry.times.airTimeClockFormat)")
            }
            //LogbookListView(entries: LogbookEntry.sampleList)
                .navigationTitle("Logbook")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    LogbookView()
}
