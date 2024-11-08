//
//  RickAndMortyInteractor.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

public struct RickAndMortyInteractor {
    private let repository: RickAndMortyRepositoryProtocol
    
    init(repository: RickAndMortyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchCharacterList(by page: Int, with filter: CharacterListFilter) async -> Result<CharacterList> {
        await repository.fetchCharacterList(by: page, with: filter)
    }
    
    public func fetchCharacterDetail(by id: Int) async -> Result<CharacterDetail> {
        await repository.fetchCharacterDetail(by: id)
    }
    
    public func fetchLocationList(by page: Int, with filter: LocationListFilter) async -> Result<LocationList> {
        await repository.fetchLocationList(by: page, with: filter)
    }
    
    public func fetchLocationDetail(by id: Int) async -> Result<LocationDetail> {
        await repository.fetchLocationDetail(by: id)
    }
}
