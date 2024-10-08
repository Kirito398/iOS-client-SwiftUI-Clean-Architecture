//
//  CharacterList.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct CharacterList {
    let info: Info
    let list: [Character]
    
    struct Info {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }

    struct Character : Identifiable {
        let id: Int
        let name: String
        let status: Status
        let species: String
        let type: String
        let gender: Gender
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
        
        enum Status {
            case unknown
            case alive
            case dead
        }
        
        enum Gender {
            case unknown
            case female
            case male
            case genderless
        }
    }
}

extension CharacterList.Character {
    static let sample = Self.init(
            id: 1,
            name: "Rick Sanchez",
            status: Self.Status.sample,
            species: "Human",
            type: "",
            gender: Self.Gender.sample,
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            origin: Self.Origin.sample,
            location: Self.Location.sample
        )
}

extension CharacterList.Character.Location {
    static let sample = Self.named(id: 20, name: "Earth")
}

extension CharacterList.Character.Origin {
    static let sample = Self.named(id: 1, name: "Earth")
}

extension CharacterList.Character.Status {
    static let sample = Self.alive
}

extension CharacterList.Character.Gender {
    static let sample = Self.male
}
