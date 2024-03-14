//
//  DecoderConfigurationError.swift
//  PilotLog
//
//  Created by Max Udaskin on 2024-03-14.
//

import Foundation

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

extension DecoderConfigurationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingManagedObjectContext:
            return NSLocalizedString("The ManagedObjectContext is missing or has not been provided.", comment: "MissingManagedObjectContext Error")
        }
    }
}
