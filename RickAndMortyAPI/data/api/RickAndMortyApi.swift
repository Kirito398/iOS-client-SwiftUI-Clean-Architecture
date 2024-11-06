//
//  RickAndMortyApi.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct RickAndMortyApi {
    private let apiClient: HttpClient
    
    init(apiClient: HttpClient) {
        self.apiClient = apiClient
    }
    
    func fetchCharacterList(by page: Int, with filter: CharacterListFilter) async throws -> CharacterList {
        let response = try await apiClient.load(CharacterListResponse.self, from: "character/?page=\(page)\(filter.mapToApi())")
        let characterList: [CharacterDetail] = try await loadCharacterAvatar(for: response.list)
        
        return CharacterList(
            info: response.info.mapToDomain(),
            list: characterList
        )
    }
    
    func fetchCharacterDetail(by id: Int) async throws -> CharacterDetail {
        let response = try await apiClient.load(CharacterListResponse.Character.self, from: "character/\(id)")
        let avatar = try await loadCharacterAvatar(by: response.image)
        return try response.mapToDomain(avatar: avatar)
    }
    
    func loadImageData(by url: URL) async throws -> Data {
        try await apiClient.loadData(from: url)
    }
    
    func fetchLocationList(by page: Int, with filter: LocationListFilter) async throws -> LocationList {
        try await apiClient.load(LocationListResponse.self, from: "location?page=\(page)\(filter.mapToApi())").mapToDomain()
    }
    
    func fetchLocationDetail(by id: Int) async throws -> LocationDetail {
        try await apiClient.load(LocationListResponse.Location.self, from: "location/\(id)").mapToDomain()
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
            let response = try await loadImageData(by: imageURL)
            return CharacterDetail.CharacterAvatar.cached(imageData: response)
        } else {
            return CharacterDetail.CharacterAvatar.failed
        }
    }
    
//    func fetchCharacterList() {
//        apiClient.loadAsync(CharacterListResponse.self, from: "character") { result in
//            
//        }
//    }
 }
