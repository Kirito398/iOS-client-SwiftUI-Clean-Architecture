//
//  RickAndMortyInteractor.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct RickAndMortyInteractor {
    private let repository: RickAndMortyRepository
    
    init(repository: RickAndMortyRepository) {
        self.repository = repository
    }
    
    func fetchCharacterList(by page: Int = 1) async throws -> CharacterList {
        try await repository.fetchCharacterList(by: page)
    }
    
    func fetchCharacterDetail(by id: Int) async throws -> CharacterDetail {
        try await repository.fetchCharacterDetail(by: id)
    }
    
    func fetchLocationList(by page: Int) async throws -> LocationList {
        try await repository.fetchLocationList(by: page)
    }
    
    func fetchLocationDetail(by id: Int) async throws -> LocationDetail {
        try await repository.fetchLocationDetail(by: id)
    }
}
