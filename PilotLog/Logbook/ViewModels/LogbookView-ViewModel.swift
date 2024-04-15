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
            entries = LogbookEntry.factory(take: 10)
//            let tempEntries = LogbookEntry.factory(take: 25)
//            for i in 0...4 {
//                for x in 1...5 {
//                    if entries["Section \(i)"] == nil {
//                        entries["Section \(i)"] = []
//                    }
//                    entries["Section \(i)"]?.append(tempEntries[i * 5 + x - 1])
//                }
//            }
        }
    }
}
