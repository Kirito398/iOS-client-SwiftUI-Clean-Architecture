//
//  CharacterListResponse.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

struct CharacterListResponse : Decodable {
    let info: Info
    let list: [Character]
    
    struct Info : Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    struct Character : Decodable {
        let id: Int
        let name: String
        let status: Status
        let species: String
        let type: String
        let gender: Gender
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
        
        enum Status : String, Decodable {
            case unknown
            case Alive
            case Dead
        }
        
        enum Gender : String, Decodable {
            case unknown
            case Female
            case Male
            case Genderless
        }
    }
}

extension CharacterListResponse {
    private enum CodingKeys: String, CodingKey {
        case info = "info"
        case list = "results"
    }
    
//    func mapToDomain() throws -> CharacterList {
//        CharacterList(
//            info: self.info.mapToDomain(),
//            list: try self.list.map { item in
//                try item.mapToDomain()
//            }
//        )
//    }
}

extension CharacterListResponse.Info {
    func mapToDomain() -> CharacterList.Info {
        CharacterList.Info(
            count: self.count,
            pages: self.pages,
            next: self.next ?? "",
            prev: self.prev ?? ""
        )
    }
}

extension CharacterListResponse.Character {
    func mapToDomain(avatar: CharacterDetail.CharacterAvatar) throws -> CharacterDetail {
        CharacterDetail(
            id: self.id,
            name: self.name,
            status: self.status.mapToDomain(),
            species: self.species,
            type: self.type,
            gender: self.gender.mapToDomain(),
            image: self.image,
            avatar: avatar,
            origin: try self.origin.mapToDomain(),
            location: try self.location.mapToDomain()
        )
    }
}

extension CharacterListResponse.Character.Origin {
    func mapToDomain() throws -> CharacterDetail.Origin {
        if self.url.isEmpty {
            CharacterDetail.Origin.unknown
        } else if let id = self.url.extractID() {
            CharacterDetail.Origin.named(
                id: id, name: self.name
            )
        } else {
            throw FailureError.dataParsingFailure(error: "Extract Origin ID from \(self) failure!")
        }
    }
}

extension CharacterListResponse.Character.Location {
    func mapToDomain() throws -> CharacterDetail.Location {
        if self.url.isEmpty {
            CharacterDetail.Location.unknown
        } else if let id = self.url.extractID() {
            CharacterDetail.Location.named(
                id: id, name: self.name
            )
        } else {
            throw FailureError.dataParsingFailure(error: "Extract Origin ID from \(self) failure!")
        }
    }
}

extension CharacterListResponse.Character.Gender {
    func mapToDomain() -> CharacterDetail.Gender {
        switch self {
        case .unknown: CharacterDetail.Gender.unknown
        case .Female: CharacterDetail.Gender.female
        case .Male: CharacterDetail.Gender.male
        case .Genderless: CharacterDetail.Gender.genderless
        }
    }
}

extension CharacterListResponse.Character.Status {
    func mapToDomain() -> CharacterDetail.Status {
        switch self {
        case .unknown: CharacterDetail.Status.unknown
        case .Alive: CharacterDetail.Status.alive
        case .Dead: CharacterDetail.Status.dead
        }
    }
}

extension String {
    func extractID() -> Int? {
        let splited: String = self.components(separatedBy: "/").last ?? ""
        return Int(splited)
    }
}
