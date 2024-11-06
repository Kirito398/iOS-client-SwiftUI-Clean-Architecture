//
//  CharacterSearchFilter.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.11.2024.
//

import Foundation

struct CharacterSearchFilter {
    let name: String
}

extension CharacterSearchFilter {
    static let defaultValue = CharacterSearchFilter(name: "")
    
    func mapToDomain() -> CharacterListFilter {
        CharacterListFilter(
            name: self.name
        )
    }
}
