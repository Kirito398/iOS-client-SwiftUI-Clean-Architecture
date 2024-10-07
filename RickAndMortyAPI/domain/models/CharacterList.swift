//
//  CharacterList.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct CharacterList {
    let info: CharacterListInfo
    let list: [CharacterInfo]
    
    struct CharacterListInfo {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }

    struct CharacterInfo : Identifiable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let image: String
        let origin: Origin
        let location: Location
        
        enum Origin {
            case unknown
            case named(id: Int, name: String)
        }
        
        enum Location {
            case unknown
            case named(id: Int, name: String)
        }
    }
}

extension CharacterList.CharacterInfo {
    static let sample = Self.init(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            origin: Self.Origin.sample,
            location: Self.Location.sample
        )
}

extension CharacterList.CharacterInfo.Location {
    static let sample = Self.named(id: 20, name: "Earth")
}

extension CharacterList.CharacterInfo.Origin {
    static let sample = Self.named(id: 1, name: "Earth")
}
