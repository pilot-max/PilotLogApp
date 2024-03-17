//
//  LogbookView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct LogbookView: View {
    @State private var viewModel = ViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var flights: FetchedResults<Flight>
    
    var body: some View {
        NavigationStack {
            List(flights) { flight in
                NavigationLink {
                    LogbookEntryDetailView(entry: flight)
                } label: {
                    LogbookListItemView(entry: flight)
                }
            }
            NavigationLink("New Entry") {
                LogbookNewEntryView()
            }
        }
        .navigationTitle("Logbook")
        .navigationBarTitleDisplayMode(.inline)
        
        // Load sample data
        .onAppear {
            viewModel.loadSampleData()
        }
    }
}


#Preview {
    LogbookView()
        .environment(\.managedObjectContext, DataController.preview.container.viewContext)
}
