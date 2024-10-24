//
//  LocationListResponse.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

struct LocationListResponse : Decodable {
    let info: Info
    let results: [Location]
    
    struct Info : Decodable {
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    struct Location : Decodable {
        let id: Int
        let name: String?
        let type: String?
        let dimension: String?
        let residents: [String]
        let created: String?
    }
}

extension LocationListResponse {
    func mapToDomain() -> LocationList {
        LocationList(
            info: self.info.mapToDomain(),
            list: self.results.map { item in
                item.mapToDomain()
            }
        )
    }
}

extension LocationListResponse.Info {
    func mapToDomain() -> LocationList.Info {
        LocationList.Info(
            pages: self.pages,
            next: self.next ?? "",
            prev: self.prev ?? ""
        )
    }
}

extension LocationListResponse.Location {
    func mapToDomain() -> LocationDetail {
        LocationDetail(
            id: self.id,
            name: self.name ?? "",
            type: self.type ?? "",
            dimension: self.dimension ?? "",
            created: self.created ?? ""
        )
    }
}
