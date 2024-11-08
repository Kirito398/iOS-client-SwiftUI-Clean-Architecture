//
//  LocationListUI.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 22.10.2024.
//

import Foundation
import domain

struct LocationListUI {
    let info: Info
    let list: [LocationDetailUI]
    
    struct Info {
        let pages: Int
        let next: String
        let prev: String
    }
}

extension LocationList {
    func mapToUiModel() -> LocationListUI {
        LocationListUI(
            info: self.info.mapToUiModel(),
            list: self.list.map { item in
                item.mapToUiModel()
            }
        )
    }
}

extension LocationList.Info {
    func mapToUiModel() -> LocationListUI.Info {
        LocationListUI.Info(
            pages: self.pages,
            next: self.next,
            prev: self.prev
        )
    }
}

extension LocationDetail {
    func mapToUiModel() -> LocationDetailUI {
        LocationDetailUI(
            id: self.id,
            name: self.name,
            type: self.type,
            dimension: self.dimension,
            created: self.created,
            geometryMatchedIds: LocationDetailUI.GeometryMatchedIds(locationId: self.id)
        )
    }
}
