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
    
//    func fetchCharacterList() {
//        apiClient.loadAsync(CharacterListResponse.self, from: "character") { result in
//            
//        }
//    }
 }
