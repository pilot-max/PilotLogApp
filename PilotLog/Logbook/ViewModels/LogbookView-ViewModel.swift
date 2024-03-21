//
//  LogbookView-ViewModel.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-08.
//

import Foundation

extension LogbookView {
    @Observable
    class ViewModel {
        private (set) var entries: [LogbookEntry] = []
        
        func loadSampleData() {
            entries = LogbookEntry.factory(take: 25)
        }
    }
}
