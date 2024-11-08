//
//  LocationSearchFilter.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 05.11.2024.
//

import Foundation
import domain

struct LocationSearchFilter {
    let name: String
}

extension LocationSearchFilter {
    static let defaultValue = Self.init(name: "")
    
    func mapToDomain() -> LocationListFilter {
        return LocationListFilter(name: self.name)
    }
}
