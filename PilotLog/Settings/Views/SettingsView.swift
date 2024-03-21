//
//  SettingsView.swift
//  PilotLog
//
//  Created by Max Udaskin on 2023-09-28.
//

import SwiftUI

struct SettingsView: View {
    @State var notifyMeAbout: Int = 1
    @State var playNotificationSounds: Bool = true
    @State var sendReadReceipts: Bool = false
    @State var profileImageSize: String = "large"
    
    var aircraft = Aircraft.factory(take: 5)
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Lists")){
                    NavigationLink {
                        AircraftListView(aircraft: aircraft)
                    } label: {
                        Text("Aircraft")
                    }
                    
                    NavigationLink {
                        AirportSettingsView()
                    } label: {
                        Text("Airports")
                    }
                    
                    NavigationLink {
                        Text("Test")
                    } label: {
                        Text("Pilots")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
