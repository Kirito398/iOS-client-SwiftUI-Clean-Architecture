//
//  LocationList.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

public struct LocationList {
    public let info: Info
    public let list: [LocationDetail]
    
    public struct Info {
        public let pages: Int
        public let next: String
        public let prev: String
    }
}

extension LocationList.Info {
    static let defaultValue = Self.init(pages: 0, next: "", prev: "")
}
