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
    
    func getCharactersList() -> [CharacterDetail] {
        cache.loadAll(CharacterObject.self).mapToDomain()
    }
    
    func saveCharacterList(list: [CharacterDetail]) throws {
        try cache.writeAll(list: list.mapToCache())
    }
}
