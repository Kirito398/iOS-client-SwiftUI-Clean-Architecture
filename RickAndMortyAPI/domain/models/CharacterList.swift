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

    struct CharacterInfo {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
    }
}
