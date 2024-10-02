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
    
    func fetchCharacterList() async throws -> CharacterList {
        try await repository.fetchCharacterList()
    }
}
