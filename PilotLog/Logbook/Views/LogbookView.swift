//
//  LogbookView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct LogbookView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.entries) { entry in
                    NavigationLink {
                        LogbookEntryDetailView(entry: entry)
                    } label: {
                        LogbookListItemView(entry: entry)
                    }
                }
            }
            .padding()
            .toolbar {
                NavigationLink {
                    LogbookNewEntryView()
                } label: {
                    Text("Add")
                }
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
}
