//
//  CharacterListFilter.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.11.2024.
//

import Foundation

struct CharacterListFilter {
    let name: String
}

extension CharacterListFilter {
    static let defaultValue = Self.init(name: "")
}
