//
//  LocationObject.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 31.10.2024.
//

import Foundation
import RealmSwift

class LocationObject : Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var dimension: String
    @Persisted var created: String
}

extension [LocationObject] {
    func mapToDomain() -> [LocationDetail] {
        return self.map { item in
            item.mapToDomain()
        }
    }
    
    func filter(by filter: LocationListFilter) -> Self {
        return self.filter { item in
            let name = filter.name.isEmpty || item.name.contains(filter.name)
            return name
        }
    }
}

extension LocationObject {
    func mapToDomain() -> LocationDetail {
        return LocationDetail(
            id: self.id,
            name: self.name,
            type: self.type,
            dimension: self.dimension,
            created: self.created
        )
    }
}

extension [LocationDetail] {
    func mapToCache() -> [LocationObject] {
        return self.map { item in
            item.mapToCache()
        }
    }
}

extension LocationDetail {
    func mapToCache() -> LocationObject {
        let object = LocationObject()
        object.id = self.id
        object.name = self.name
        object.type = self.type
        object.dimension = self.dimension
        object.created = self.created
        return object
    }
}

