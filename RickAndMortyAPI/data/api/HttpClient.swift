//
//  HttpClient.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

class HttpClient {
    private let baseUrl: String
    private let session: URLSession
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = 15
        
        session = URLSession(configuration: config)
    }
    
    func load<T : Decodable>(from pathUrl: String) async throws -> T {
        if let url = URL(string: baseUrl + pathUrl) {
            do {
                let data = try await loadData(from: url)
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                throw handleError(error)
            }
        } else {
            throw FailureError.badURL(error: "URL: \(baseUrl + pathUrl) is incorrect!")
        }
    }
    
    func loadData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await session.data(from: url)
            return data
        } catch {
            throw handleError(error)
        }
    }
    
    private func handleError(_ error: Error) -> FailureError {
        switch error {
        case is DecodingError: FailureError.dataParsingFailure(error: error.localizedDescription)
        default: FailureError.connectionError(error: error.localizedDescription)
        }
    }
}
