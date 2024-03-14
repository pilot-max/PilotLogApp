//
//  PilotLogApp.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-27.
//

import SwiftUI

@main
struct PilotLogApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
