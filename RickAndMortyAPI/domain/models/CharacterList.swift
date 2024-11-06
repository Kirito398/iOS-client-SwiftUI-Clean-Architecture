//
//  CharacterList.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct CharacterList {
    let info: Info
    let list: [CharacterDetail]
    
    struct Info {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
}

extension CharacterList.Info {
    static let defaultValue = Self.init(count: 0, pages: 0, next: "", prev: "")
}
