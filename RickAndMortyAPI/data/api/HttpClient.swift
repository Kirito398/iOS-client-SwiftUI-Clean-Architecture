//
//  HttpClient.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

class HttpClient {
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func load<T : Decodable>(from pathUrl: String) async throws -> T {
        if let url = URL(string: baseUrl + pathUrl) {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            throw FailureError.badURL
        }
    }
    
//    func loadAsync<T : Decodable>(_ type: T.Type, from pathUrl: String, withCompletion completion: @escaping (RequestResult<T>) -> Void) {
//        if let url = URL(string: baseUrl + pathUrl) {
//            let task = URLSession.shared.dataTask(with: url) { data, _, error in
//                if let data = data {
//                    do {
//                        let result = try JSONDecoder().decode(T.self, from: data)
//                        DispatchQueue.main.async {
//                            completion(RequestResult.success(result: result))
//                        }
//                    } catch {
//                        DispatchQueue.main.async {
//                            completion(RequestResult.failure(error: error.localizedDescription))
//                        }
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        completion(RequestResult.failure(error: error?.localizedDescription ?? "Unknown error"))
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
}

//enum RequestResult<T> {
//    case success(result: T)
//    case failure(error: String)
//}
