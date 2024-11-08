//
//  RickAndMortyRepositoryProtocol.swift
//  domain
//
//  Created by Ilgiz Sultanbekov on 07.11.2024.
//

import Foundation

protocol RickAndMortyRepositoryProtocol {
    func fetchCharacterList(by page: Int, with filter: CharacterListFilter) async -> Result<CharacterList>
    
    func fetchCharacterDetail(by id: Int) async -> Result<CharacterDetail>
    
    func fetchLocationList(by page: Int, with filter: LocationListFilter) async -> Result<LocationList>
    
    func fetchLocationDetail(by id: Int) async -> Result<LocationDetail>
}
