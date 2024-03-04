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
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Lists")){
                    NavigationLink {
                        AircraftListView()
                    } label: {
                        Text("Aircraft")
                    }
                    
                    NavigationLink {
                        Text("Test")
                    } label: {
                        Text("Pilots")
                    }
                }
                Section(header: Text("Notifications")) {
                    Picker("Notify Me About", selection: $notifyMeAbout) {
                        Text("Direct Messages").tag(1)
                        Text("Mentions").tag(2)
                        Text("Anything").tag(3)
                    }
                    Toggle("Play notification sounds", isOn: $playNotificationSounds)
                    Toggle("Send read receipts", isOn: $sendReadReceipts)
                }
                Section(header: Text("User Profiles")) {
                    Picker("Profile Image Size", selection: $profileImageSize) {
                        Text("Large").tag("large")
                        Text("Medium").tag("medium")
                        Text("Small").tag("small")
                    }
                    Button("Clear Image Cache") {}
                }
                Section(header: Text("Notifications")) {
                    Picker("Notify Me About", selection: $notifyMeAbout) {
                        Text("Direct Messages").tag(1)
                        Text("Mentions").tag(2)
                        Text("Anything").tag(3)
                    }
                    Toggle("Play notification sounds", isOn: $playNotificationSounds)
                    Toggle("Send read receipts", isOn: $sendReadReceipts)
                }
                Section(header: Text("User Profiles")) {
                    Picker("Profile Image Size", selection: $profileImageSize) {
                        Text("Large").tag("large")
                        Text("Medium").tag("medium")
                        Text("Small").tag("small")
                    }
                    Button("Clear Image Cache") {}
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
