//
//  SettingsViewModel.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-17.
//

import Foundation

extension SettingsView {
    @Observable
    class ViewModel {
        let defaults = UserDefaults.standard
        var printDebugMessages: Bool {
            didSet { defaults.set(printDebugMessages, forKey: "printDebugMessages") }
        }
        var airportRunwayMinimumLength: Int {
            didSet { defaults.set(airportRunwayMinimumLength, forKey: "airportRunwayMinimumLength") }
        }
        var airportRunwayMinimumWidth: Int {
            didSet { defaults.set(airportRunwayMinimumWidth, forKey: "airportRunwayMinimumWidth") }
        }
        var airportScheduledService: Bool {
            didSet { defaults.set(airportScheduledService, forKey: "airportScheduledService") }
        }
        var airportDisplayContinents: [String] {
            didSet { defaults.set(airportDisplayContinents, forKey: "airportDisplayContinents") }
        }
        var airportDisplayCountries: [String] {
            didSet { defaults.set(airportDisplayCountries, forKey: "airportDisplayCountries") }
        }
        
        init() {
            self.printDebugMessages = defaults.bool(forKey: "printDebugMessages")
            
            self.airportRunwayMinimumLength = defaults.integer(forKey: "airportRunwayMinimumLength")
            self.airportRunwayMinimumWidth = defaults.integer(forKey: "airportRunwayMinimumWidth")
            self.airportScheduledService = defaults.bool(forKey: "airportScheduledService")
            self.airportDisplayContinents = defaults.array(forKey: "airportDisplayContinents") as? [String] ?? []
            self.airportDisplayCountries = defaults.array(forKey: "airportDisplayCountries") as? [String] ?? []
        }
    }
}
