//
//  ApiExtensions.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.11.2024.
//

import Foundation

extension CharacterListFilter {
    func mapToApi() -> String {
        var result = ""
        if !name.isEmpty {
            result += "&name=\(name)"
        }
        return result
    }
}
