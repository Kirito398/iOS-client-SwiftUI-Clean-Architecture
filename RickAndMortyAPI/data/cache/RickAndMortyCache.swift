//
//  RickAndMortyCache.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 25.10.2024.
//

import Foundation
import RealmSwift

final class RickAndMortyCache {
    private let cache: RealmService
    
    init(cache: RealmService) {
        self.cache = cache
    }
    
    func getCharactersList() throws -> [CharacterDetail] {
        try cache.loadAll(CharacterObject.self).mapToDomain()
    }
    
    func getCharacter(by characterId: Int) throws -> CharacterDetail {
        try cache.load(CharacterObject.self, forPrimaryKey: characterId).mapToDomain()
    }
    
    func saveCharacterList(_ list: [CharacterDetail]) throws {
        try cache.writeAll(list: list.mapToCache())
    }
}
