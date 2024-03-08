//
//  LogbookEntryDetailView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-10-04.
//

import SwiftUI

struct LogbookEntryDetailView: View {
    let entry: LogbookEntry
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    var body: some View {
        VStack {
            Text("\(dateFormatter.string(from: entry.date))")
            Text("\(entry.id)")
        }
    }
}

#Preview {
    LogbookEntryDetailView(entry: LogbookEntry.sampleEntries().first!)
}
