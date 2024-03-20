//
//  LogbookView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct LogbookView: View {
    @State private var viewModel = ViewModel()
    //@FetchRequest(sortDescriptors: []) var flights: FetchedResults<Flight>
    
    var body: some View {
        NavigationStack {
//            List(flights) { flight in
//                NavigationLink {
//                    LogbookEntryDetailView(entry: flight)
//                        .environment(viewModel)
//                } label: {
//                    LogbookListItemView(entry: flight)
//                }
//            }
            Text("No flights... todo")
            NavigationLink("New Entry") {
                LogbookNewEntryView(viewModel: viewModel)
            }
        }
        .navigationTitle("Logbook")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    LogbookView()
}
