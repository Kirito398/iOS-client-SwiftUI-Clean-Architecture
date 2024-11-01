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
        case .badURL: "Bad URL"
        case .unknown(_): "Unknown Error"
        case .dataParsingFailure(_): "Failure"
        case .connectionError(_): "Connection Error"
        }
    }
    
    var message: String {
        switch self {
        case .badURL: "Unknown URL"
        case .unknown(error: let error): error
        case .dataParsingFailure(_): "Parsing data failured"
        case .connectionError(let error): error
        }
    }
    
}
