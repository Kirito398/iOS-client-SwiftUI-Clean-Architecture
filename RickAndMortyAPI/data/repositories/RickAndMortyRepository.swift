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
    
    func fetchCharacterList(by page: Int) async throws -> CharacterList {
        let response = try await rickAndMortyApi.fetchCharacterList(by: page)
        
        var characterList: [CharacterDetail] = []
        
        for item in response.list {
            let avatar = try await loadCharacterAvatar(by: item.image)
            let characterDetail = try item.mapToDomain(avatar: avatar)
            characterList.append(characterDetail)
        }
        
        return CharacterList(
            info: response.info.mapToDomain(),
            list: characterList
        )
    }
    
    func fetchCharacterDetail(by id: Int) async throws -> CharacterDetail {
        //try await rickAndMortyApi.fetchCharacterDetail(by: id).mapToDomain()
        let response = try await rickAndMortyApi.fetchCharacterDetail(by: id)
        let avatar = try await loadCharacterAvatar(by: response.image)
        return try response.mapToDomain(avatar: avatar)
    }
    
    func loadCharacterAvatar(by stringURL: String) async throws -> CharacterDetail.CharacterAvatar {
        if let imageURL = URL(string: stringURL) {
            let response = try await rickAndMortyApi.loadImageData(by: imageURL)
            return CharacterDetail.CharacterAvatar.cached(imageData: response)
        } else {
            return CharacterDetail.CharacterAvatar.failed
        }
    }
}
