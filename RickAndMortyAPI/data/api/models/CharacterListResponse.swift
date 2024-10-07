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
        let image: String
        let origin: Origin
        let location: Location
        
        struct Origin : Decodable {
            let name: String
            let url: String
        }
        
        struct Location : Decodable {
            let name: String
            let url: String
        }
    }
}

extension CharacterListResponse {
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case list = "results"
    }
    
    func mapToDomain() throws -> CharacterList {
        CharacterList(
            info: self.info.mapToDomain(),
            list: try self.list.map { item in
                try item.mapToDomain()
            }
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

extension CharacterListResponse.CharacterInfo {
    func mapToDomain() throws -> CharacterList.CharacterInfo {
        CharacterList.CharacterInfo(
            id: self.id,
            name: self.name,
            status: self.status,
            species: self.species,
            type: self.type,
            gender: self.gender,
            image: self.image,
            origin: try self.origin.mapToDomain(),
            location: try self.location.mapToDomain()
        )
    }
}

extension CharacterListResponse.CharacterInfo.Origin {
    func mapToDomain() throws -> CharacterList.CharacterInfo.Origin {
        if self.url.isEmpty {
            CharacterList.CharacterInfo.Origin.unknown
        } else if let id = self.url.extractID() {
            CharacterList.CharacterInfo.Origin.named(
                id: id, name: self.name
            )
        } else {
            throw FailureError.dataParsingFailure(error: "Extract Origin ID from \(self) failure!")
        }
    }
}

extension CharacterListResponse.CharacterInfo.Location {
    func mapToDomain() throws -> CharacterList.CharacterInfo.Location {
        if self.url.isEmpty {
            CharacterList.CharacterInfo.Location.unknown
        } else if let id = self.url.extractID() {
            CharacterList.CharacterInfo.Location.named(
                id: id, name: self.name
            )
        } else {
            throw FailureError.dataParsingFailure(error: "Extract Origin ID from \(self) failure!")
        }
    }
}

extension String {
    func extractID() -> Int? {
        let splited: String = self.components(separatedBy: "/").last ?? ""
        return Int(splited)
    }
}
