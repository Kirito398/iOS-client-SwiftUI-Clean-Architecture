//
//  CharacterDetail.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation

struct CharacterDetail : Identifiable {
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

extension CharacterDetail {
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

extension CharacterDetail.Location {
    static let sample = Self.named(id: 20, name: "Earth")
}

extension CharacterDetail.Origin {
    static let sample = Self.named(id: 1, name: "Earth")
}

extension CharacterDetail.Status {
    static let sample = Self.alive
}

extension CharacterDetail.Gender {
    static let sample = Self.male
}
