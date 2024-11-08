//
//  CharacterList.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

public struct CharacterList {
    public let info: Info
    public let list: [CharacterDetail]
    
    public struct Info {
        public let count: Int
        public let pages: Int
        public let next: String
        public let prev: String
    }
}

extension CharacterList.Info {
    static let defaultValue = Self.init(count: 0, pages: 0, next: "", prev: "")
}
