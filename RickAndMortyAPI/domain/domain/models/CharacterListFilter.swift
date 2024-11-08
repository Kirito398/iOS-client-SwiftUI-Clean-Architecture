//
//  CharacterListFilter.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.11.2024.
//

import Foundation

public struct CharacterListFilter {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

extension CharacterListFilter {
    static let defaultValue = Self.init(name: "")
}
