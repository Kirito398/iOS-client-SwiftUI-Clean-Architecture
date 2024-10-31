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
    
    func getCharacterDetail(by characterId: Int) throws -> CharacterDetail {
        try cache.load(CharacterObject.self, forPrimaryKey: characterId).mapToDomain()
    }
    
    func getLocationList() throws -> [LocationDetail] {
        try cache.loadAll(LocationObject.self).mapToDomain()
    }
    
    func getLocationDetail(by locationId: Int) throws -> LocationDetail {
        try cache.load(LocationObject.self, forPrimaryKey: locationId).mapToDomain()
    }
    
    func saveCharacterList(_ list: [CharacterDetail]) throws {
        try cache.writeAll(list: list.mapToCache())
    }
    
    func saveCharaterDetail(_ characterDetail: CharacterDetail) throws {
        try cache.write(object: characterDetail.mapToCache())
    }
    
    func saveLocationList(_ list: [LocationDetail]) throws {
        try cache.writeAll(list: list.mapToCache())
    }
    
    func saveLocationDetail(_ locationDetail: LocationDetail) throws {
        try cache.write(object: locationDetail.mapToCache())
    }
}
