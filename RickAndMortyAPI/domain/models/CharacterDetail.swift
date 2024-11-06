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
    let avatar: CharacterAvatar
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
    
    enum CharacterAvatar {
        case cached(imageData: Data)
        case failed
    }
}
