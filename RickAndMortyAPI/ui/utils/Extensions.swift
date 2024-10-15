//
//  Extensions.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

extension CharacterDetail.Status {
    var color: Color {
        switch self {
        case .unknown: Color.lightGray
        case .alive: Color.lightGreen
        case .dead: Color.red
        }
    }
    
    func toString() -> String {
        switch self {
        case .unknown: "Unknown"
        case .alive: "Alive"
        case .dead: "Dead"
        }
    }
}

extension CharacterDetail.Origin {
    var name: String {
        switch self {
        case .unknown: "Unknown"
        case .named(id: _, name: let name): name
        }
    }
}

extension CharacterDetail.Location {
    var name: String {
        switch self {
        case .unknown: "Unknown"
        case .named(id: _, name: let name): name
        }
    }
}

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
