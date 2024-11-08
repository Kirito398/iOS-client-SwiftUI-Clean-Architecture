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
    
    func fetchCharacterList(by page: Int, with filter: CharacterListFilter) async -> Result<CharacterList> {
        await repository.fetchCharacterList(by: page, with: filter)
    }
    
    func fetchCharacterDetail(by id: Int) async -> Result<CharacterDetail> {
        await repository.fetchCharacterDetail(by: id)
    }
    
    func fetchLocationList(by page: Int, with filter: LocationListFilter) async -> Result<LocationList> {
        await repository.fetchLocationList(by: page, with: filter)
    }
    
    func fetchLocationDetail(by id: Int) async -> Result<LocationDetail> {
        await repository.fetchLocationDetail(by: id)
    }
}
