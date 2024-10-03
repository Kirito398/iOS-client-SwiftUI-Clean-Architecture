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
    
    func fetchCharacterList() async throws -> CharacterListResponse {
        try await apiClient.load(from: "character")
    }
    
//    func fetchCharacterList() {
//        apiClient.loadAsync(CharacterListResponse.self, from: "character") { result in
//            
//        }
//    }
 }
