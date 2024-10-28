//
//  RickAndMortyRepository.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct RickAndMortyRepository {
    private let api: RickAndMortyApi
    private let cache: RickAndMortyCache
    
    init(api: RickAndMortyApi, cache: RickAndMortyCache) {
        self.api = api
        self.cache = cache
    }
    
    func fetchCharacterList(by page: Int) async -> Result<CharacterList> {
        await tryDoWithCaching {
            try await fetchCharacterListFromServer(by: page)
        } saveToCache: { serverData in
            saveCharacterList(serverData.list)
        } loadFromCache: {
            let cachedData = try cache.getCharactersList()
            return CharacterList(
                info: CharacterList.Info.defaultValue,
                list: cachedData
            )
        }
    }
    
    func fetchCharacterDetail(by id: Int) async -> Result<CharacterDetail> {
        await tryDoWithCaching {
            try await fetchCharacterDetailFromServer(by: id)
        } saveToCache: { serverData in
            saveCharacterList([serverData])
        } loadFromCache: {
            try cache.getCharacter(by: id)
        }
    }
    
    func fetchLocationList(by page: Int) async -> Result<LocationList> {
        await tryDoWithCaching {
            try await api.fetchLocationList(by: page).mapToDomain()
        } saveToCache: { serverData in
            //TODO: Save
        }
    }
    
    func fetchLocationDetail(by id: Int) async -> Result<LocationDetail> {
        await tryDoWithCaching {
            try await api.fetchLocationDetail(by: id).mapToDomain()
        } saveToCache: { serverData in
            //TODO: Save
        }
    }
    
    private func fetchCharacterListFromServer(by page: Int) async throws -> CharacterList {
        let response = try await api.fetchCharacterList(by: page)
        
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
    
    private func fetchCharacterDetailFromServer(by id: Int) async throws -> CharacterDetail {
        let response = try await api.fetchCharacterDetail(by: id)
        let avatar = try await loadCharacterAvatar(by: response.image)
        return try response.mapToDomain(avatar: avatar)
    }
    
    private func loadCharacterAvatar(by stringURL: String) async throws -> CharacterDetail.CharacterAvatar {
        if let imageURL = URL(string: stringURL) {
            let response = try await api.loadImageData(by: imageURL)
            return CharacterDetail.CharacterAvatar.cached(imageData: response)
        } else {
            return CharacterDetail.CharacterAvatar.failed
        }
    }
    
    private func saveCharacterList(_ list: [CharacterDetail]) {
        do {
            try cache.saveCharacterList(list)
        } catch {
            error.localizedDescription.errorLog()
        }
    }
    
    private func tryDoWithCaching<D>(
        _ block: () async throws -> D,
        saveToCache: (D) -> Void,
        loadFromCache: (() throws -> D)? = nil
    ) async -> Result<D> {
        do {
            let result = try await block()
            saveToCache(result)
            return Result.Success(data: result)
        } catch {
            let failure = error as? FailureError ?? FailureError.unknown(error: error.localizedDescription)
            let cachedData = tryLoadFromCache(loadFromCache)
            return Result.Failure(data: cachedData, error: failure)
        }
    }
    
    private func tryLoadFromCache<D>(_ loadFromCache: (() throws -> D)?) -> D? {
        if let block = loadFromCache {
            do {
                return try block()
            } catch {
                error.localizedDescription.errorLog()
            }
        }
        return nil
    }
}
