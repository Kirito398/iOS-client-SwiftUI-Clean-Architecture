//
//  RickAndMortyRepository.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct RickAndMortyRepository {
    private let rickAndMortyApi: RickAndMortyApi
    
    init(rickAndMortyApi: RickAndMortyApi) {
        self.rickAndMortyApi = rickAndMortyApi
    }
    
    func fetchCharacterList() async throws -> CharacterList {
        try await rickAndMortyApi.fetchCharacterList().mapToDomain()
    }
}
