//
//  CharacterDetailUISamples.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 16.10.2024.
//

import Foundation

extension CharacterDetailUI {
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

extension CharacterDetailUI.Location {
    static let sample = Self.named(id: 20, name: "Earth")
}

extension CharacterDetailUI.Origin {
    static let sample = Self.named(id: 1, name: "Earth")
}

extension CharacterDetailUI.Status {
    static let sample = Self.alive
}

extension CharacterDetailUI.Gender {
    static let sample = Self.male
}
