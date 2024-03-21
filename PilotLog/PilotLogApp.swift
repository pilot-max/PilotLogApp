//
//  PilotLogApp.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-27.
//

import SwiftData
import SwiftUI

@main
struct PilotLogApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
//                .modelContainer(for: [
//                    Aircraft.self,
//                    AircraftType.self,
//                    Airport.self
//                ])
        }
    }
}
