//
//  LocationDetailUI.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 22.10.2024.
//

import Foundation

struct LocationDetailUI : Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let created: String
    let geometryMatchedIds: GeometryMatchedIds
    
    struct GeometryMatchedIds {
        private let locationId: Int
        
        init(locationId: Int) {
            self.locationId = locationId
        }
        
        var block: String {
            "location_block_\(locationId)"
        }
    }
}

extension LocationDetailUI : Equatable {
    static func == (lhs: LocationDetailUI, rhs: LocationDetailUI) -> Bool {
        lhs.id == rhs.id
    }
}
