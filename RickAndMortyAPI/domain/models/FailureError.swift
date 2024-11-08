//
//  Error.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

enum FailureError : Error, Equatable {
    case badURL(error: String)
    case unknown(error: String)
    case dataParsingFailure(error: String)
    case connectionError(error: String)
}

extension FailureError {
    var errorMessage: String {
        switch self {
        case .badURL(let error),
             .unknown(let error),
             .connectionError(let error),
             .dataParsingFailure(let error):
            return error
        }
    }
    
    var isCritical: Bool {
        switch self {
        case .connectionError(_): return false
        default: return true
        }
    }
}
