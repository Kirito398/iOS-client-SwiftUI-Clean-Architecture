//
//  Extensions.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

extension FailureError {
    
    var title: String {
        switch self {
        case .badURL:
            "Bad URL"
        case .unknown(error: _):
            "Unknown Error"
        case .dataParsingFailure(error: _):
            "Failure"
        }
    }
    
    var message: String {
        switch self {
        case .badURL:
            "Unknown URL"
        case .unknown(error: let error):
            error
        case .dataParsingFailure(error: _):
            "Parsing data failured"
        }
    }
    
}
