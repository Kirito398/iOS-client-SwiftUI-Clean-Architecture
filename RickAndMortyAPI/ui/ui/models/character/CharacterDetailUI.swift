//
//  CharacterDetailUI.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 16.10.2024.
//

import SwiftUI

struct CharacterDetailUI : Identifiable {
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
    let geometryMatchedIds: GeometryMatchedIds
    
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
        case cached(uiImage: UIImage)
        case failed(defaultAvatar: ImageResource)
    }
    
    struct GeometryMatchedIds {
        let characterId: Int
        
        var detailBlock: String {
            "character_block_\(characterId)"
        }
        
        var avatar: String {
            "character_avatar_\(characterId)"
        }
        
        var name: String {
            "character_name_\(characterId)"
        }
        
        var status: String {
            "character_status_\(characterId)"
        }
    }
}

extension CharacterDetailUI : Equatable {
    static func ==(lhs: CharacterDetailUI, rhs: CharacterDetailUI) -> Bool {
        return lhs.id == rhs.id
    }
}
