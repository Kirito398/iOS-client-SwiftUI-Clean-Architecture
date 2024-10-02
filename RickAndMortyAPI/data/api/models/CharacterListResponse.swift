//
//  CharacterListResponse.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct CharacterListResponse : Decodable {
    let info: CharacterListInfo
    let list: [CharacterInfo]
    
    struct CharacterListInfo : Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    struct CharacterInfo : Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
    }
}

extension CharacterListResponse {
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case list = "results"
    }
    
    func mapToDomain() -> CharacterList {
        CharacterList(
            info: self.info.mapToDomain(),
            list: self.list.map { item in
                item.mapToDomain()
            }
        )
    }
}

extension CharacterListResponse.CharacterInfo {
    func mapToDomain() -> CharacterList.CharacterInfo {
        CharacterList.CharacterInfo(
            id: self.id,
            name: self.name,
            status: self.status,
            species: self.species,
            type: self.type,
            gender: self.gender
        )
    }
}

extension CharacterListResponse.CharacterListInfo {
    func mapToDomain() -> CharacterList.CharacterListInfo {
        CharacterList.CharacterListInfo(
            count: self.count,
            pages: self.pages,
            next: self.next ?? "",
            prev: self.prev ?? ""
        )
    }
}


