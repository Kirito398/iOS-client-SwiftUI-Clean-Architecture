//
//  LocationList.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

struct LocationList {
    let info: Info
    let list: [LocationDetail]
    
    struct Info {
        let pages: Int
        let next: String
        let prev: String
    }
}
