//
//  Error.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

public enum FailureError : Error, Equatable {
    case badURL(error: String)
    case unknown(error: String)
    case dataParsingFailure(error: String)
    case connectionError(error: String)
}

extension FailureError {
    public var errorMessage: String {
        switch self {
        case .badURL(let error),
             .unknown(let error),
             .connectionError(let error),
             .dataParsingFailure(let error):
            return error
        }
    }
    
    public var isCritical: Bool {
        switch self {
        case .connectionError(_): return false
        default: return true
        }
    }
}
