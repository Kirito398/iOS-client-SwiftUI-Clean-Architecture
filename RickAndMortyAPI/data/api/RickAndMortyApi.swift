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
    
    func fetchCharacterList(by page: Int) async throws -> CharacterListResponse {
        try await apiClient.load(from: "character/?page=\(page)")
    }
    
    func fetchCharacterDetail(by id: Int) async throws -> CharacterListResponse.Character {
        try await apiClient.load(from: "character/\(id)")
    }
    
    func loadImageData(by url: URL) async throws -> Data {
        try await apiClient.loadData(from: url)
    }
    
    func fetchLocationList(by page: Int) async throws -> LocationListResponse {
        try await apiClient.load(from: "location?page=\(page)")
    }
    
    func fetchLocationDetail(by id: Int) async throws -> LocationListResponse.Location {
        try await apiClient.load(from: "location/\(id)")
    }
    
//    func fetchCharacterList() {
//        apiClient.loadAsync(CharacterListResponse.self, from: "character") { result in
//            
//        }
//    }
 }
