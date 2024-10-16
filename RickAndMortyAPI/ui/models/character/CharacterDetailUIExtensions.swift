//
//  CharacterDetailUIExtensions.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 16.10.2024.
//

import SwiftUI

extension CharacterDetailUI.Status {
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

extension CharacterDetailUI.Origin {
    var name: String {
        switch self {
        case .unknown: "Unknown"
        case .named(id: _, name: let name): name
        }
    }
}

extension CharacterDetailUI.Location {
    var name: String {
        switch self {
        case .unknown: "Unknown"
        case .named(id: _, name: let name): name
        }
    }
}
