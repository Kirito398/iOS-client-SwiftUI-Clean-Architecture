//
//  CharacterDetail.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation

public struct CharacterDetail : Identifiable {
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String
    public let type: String
    public let gender: Gender
    public let image: String
    public let avatar: CharacterAvatar
    public let origin: Origin
    public let location: Location
    
    public enum Origin {
        case unknown
        case named(id: Int, name: String)
    }
    
    public enum Location {
        case unknown
        case named(id: Int, name: String)
    }
    
    public enum Status {
        case unknown
        case alive
        case dead
    }
    
    public enum Gender {
        case unknown
        case female
        case male
        case genderless
    }
    
    public enum CharacterAvatar {
        case cached(imageData: Data)
        case failed
    }
}
