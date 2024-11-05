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
    
    func fetchCharacterList(by page: Int, with filter: CharacterListFilter) async -> Result<CharacterList> {
        await tryDoWithCaching {
            try await fetchCharacterListFromServer(by: page, with: filter)
        } saveToCache: { serverData in
            try cache.saveCharacterList(serverData.list)
        } loadFromCache: {
            let cachedData = try cache.getCharactersList(by: filter)
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
            try cache.saveCharaterDetail(serverData)
        } loadFromCache: {
            try cache.getCharacterDetail(by: id)
        }
    }
    
    func fetchLocationList(by page: Int) async -> Result<LocationList> {
        await tryDoWithCaching {
            try await api.fetchLocationList(by: page).mapToDomain()
        } saveToCache: { serverData in
            try cache.saveLocationList(serverData.list)
        } loadFromCache: {
            let cachedData = try cache.getLocationList()
            return LocationList(
                info: LocationList.Info.defaultValue,
                list: cachedData
            )
        }
    }
    
    func fetchLocationDetail(by id: Int) async -> Result<LocationDetail> {
        await tryDoWithCaching {
            try await api.fetchLocationDetail(by: id).mapToDomain()
        } saveToCache: { serverData in
            try cache.saveLocationDetail(serverData)
        } loadFromCache: {
            try cache.getLocationDetail(by: id)
        }
    }
    
    private func fetchCharacterListFromServer(by page: Int, with filter: CharacterListFilter) async throws -> CharacterList {
        let response = try await api.fetchCharacterList(by: page, with: filter)
        let characterList: [CharacterDetail] = try await loadCharacterAvatar(for: response.list)
        
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
    
    private func loadCharacterAvatar(for list: [CharacterListResponse.Character]) async throws -> [CharacterDetail] {
        var characterList: [CharacterDetail] = []
        
        for item in list {
            let avatar = try await loadCharacterAvatar(by: item.image)
            let characterDetail = try item.mapToDomain(avatar: avatar)
            characterList.append(characterDetail)
        }
        
        return characterList
    }
    
    private func loadCharacterAvatar(by stringURL: String) async throws -> CharacterDetail.CharacterAvatar {
        if let imageURL = URL(string: stringURL) {
            let response = try await api.loadImageData(by: imageURL)
            return CharacterDetail.CharacterAvatar.cached(imageData: response)
        } else {
            return CharacterDetail.CharacterAvatar.failed
        }
    }
    
    //MARK: Handle errors
    
    private func tryDoWithCaching<D>(
        _ block: () async throws -> D,
        saveToCache: (D) throws -> Void,
        loadFromCache: @escaping () throws -> D
    ) async -> Result<D> {
        do {
            let result = try await block()
            trySaveToCache(saveToCache, data: result)
            return Result.Success(data: result)
        } catch {
            let failure = handleError(error)
            let cachedData = tryLoadFromCache(loadFromCache)
            return Result.Failure(data: cachedData, error: failure)
        }
    }
    
    private func trySaveToCache<D>(_ saveBlock: (D) throws -> Void, data: D) {
        do {
            try saveBlock(data)
        } catch {
            _ = handleError(error)
        }
    }
    
    private func tryLoadFromCache<D>(_ loadBlock: () throws -> D) -> D? {
        do {
            return try loadBlock()
        } catch {
            _ = handleError(error)
            return nil
        }
    }
    
    private func handleError(_ error: Error) -> FailureError {
        error.localizedDescription.errorLog()
        return error as? FailureError ?? FailureError.unknown(error: error.localizedDescription)
    }
}
