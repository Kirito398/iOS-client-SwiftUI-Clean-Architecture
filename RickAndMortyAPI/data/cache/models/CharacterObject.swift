//
//  CharacterObject.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 25.10.2024.
//

import Foundation
import RealmSwift

class CharacterObject : Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var status: Status
    @Persisted var species: String
    @Persisted var type: String
    @Persisted var gender: Gender
    @Persisted var image: String
    @Persisted var avatar: Data?
    @Persisted var origin: Origin?
    @Persisted var location: Location?
    
    @objc(Origin)
    class Origin : Object {
        @Persisted(primaryKey: true) var id: Int
        @Persisted var name: String
    }
    
    @objc(Location)
    class Location : Object {
        @Persisted(primaryKey: true) var id: Int
        @Persisted var name: String
    }
    
    enum Status : String, PersistableEnum {
        case unknown
        case Alive
        case Dead
    }
    
    enum Gender : String, PersistableEnum {
        case unknown
        case Female
        case Male
        case Genderless
    }
}

//MARK: Map to domain extensions

extension [CharacterObject] {
    func mapToDomain() -> [CharacterDetail] {
        self.map { item in
            item.mapToDomain()
        }
    }
}

extension CharacterObject {
    func mapToDomain() -> CharacterDetail {
        CharacterDetail(
            id: self.id,
            name: self.name,
            status: self.status.mapToDomain(),
            species: self.species,
            type: self.type,
            gender: self.gender.mapToDomain(),
            image: self.image,
            avatar: self.avatar.mapToDomainAvatar(),
            origin: self.origin.mapToDomain(),
            location: self.location.mapToDomain()
        )
    }
}

extension CharacterObject.Status {
    func mapToDomain() -> CharacterDetail.Status {
        switch self {
        case .unknown: CharacterDetail.Status.unknown
        case .Alive: CharacterDetail.Status.alive
        case .Dead: CharacterDetail.Status.dead
        }
    }
}

extension CharacterObject.Gender {
    func mapToDomain() -> CharacterDetail.Gender {
        switch self {
        case .unknown: CharacterDetail.Gender.unknown
        case .Female: CharacterDetail.Gender.female
        case .Male: CharacterDetail.Gender.male
        case .Genderless: CharacterDetail.Gender.genderless
        }
    }
}

extension CharacterObject.Origin? {
    func mapToDomain() -> CharacterDetail.Origin {
        if let origin = self {
            return CharacterDetail.Origin.named(id: origin.id, name: origin.name)
        }
        return CharacterDetail.Origin.unknown
    }
}

extension CharacterObject.Location? {
    func mapToDomain() -> CharacterDetail.Location {
        if let location = self {
            return CharacterDetail.Location.named(id: location.id, name: location.name)
        }
        return CharacterDetail.Location.unknown
    }
}

extension Data? {
    func mapToDomainAvatar() -> CharacterDetail.CharacterAvatar {
        if let imageData = self {
            return CharacterDetail.CharacterAvatar.cached(imageData: imageData)
        }
        return CharacterDetail.CharacterAvatar.failed
    }
}

//MARK: Map To Cache extensions

extension [CharacterDetail] {
    func mapToCache() -> [CharacterObject] {
        self.map { item in
            item.mapToCache()
        }
    }
}

extension CharacterDetail {
    func mapToCache() -> CharacterObject {
        let object = CharacterObject()
        object.id = self.id
        object.name = self.name
        object.status = self.status.mapToCache()
        object.species = self.species
        object.type = self.type
        object.gender = self.gender.mapToCache()
        object.image = self.image
        object.avatar = self.avatar.mapToCache()
        object.origin = self.origin.mapToCache()
        object.location = self.location.mapToCache()
        return object
    }
}

extension CharacterDetail.Origin {
    func mapToCache() -> CharacterObject.Origin? {
        if case .named(let id, let name) = self {
            let object = CharacterObject.Origin()
            object.id = id
            object.name = name
            return object
        }
        
        return nil
    }
}

extension CharacterDetail.Location {
    func mapToCache() -> CharacterObject.Location? {
        if case .named(let id, let name) = self {
            let object = CharacterObject.Location()
            object.id = id
            object.name = name
            return object
        }
        
        return nil
    }
}

extension CharacterDetail.Status {
    func mapToCache() -> CharacterObject.Status {
        switch self {
        case .unknown: CharacterObject.Status.unknown
        case .alive: CharacterObject.Status.Alive
        case .dead: CharacterObject.Status.Dead
        }
    }
}

extension CharacterDetail.Gender {
    func mapToCache() -> CharacterObject.Gender {
        switch self {
        case .unknown: CharacterObject.Gender.unknown
        case .female: CharacterObject.Gender.Female
        case .male: CharacterObject.Gender.Male
        case .genderless: CharacterObject.Gender.Genderless
        }
    }
}

extension CharacterDetail.CharacterAvatar {
    func mapToCache() -> Data? {
        switch self {
        case .cached(let imageData): imageData
        case .failed: nil
        }
    }
}
