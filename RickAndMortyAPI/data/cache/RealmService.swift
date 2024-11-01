//
//  RealmService.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 25.10.2024.
//

import Foundation
import RealmSwift

final class RealmService {    
    func writeAll(list: [Object]) throws {
        let realm = try Realm()
        try realm.write {
            list.forEach { item in
                realm.add(item, update: .all)
            }
        }
    }
    
    func write(object: Object) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func loadAll<Item : Object>(_ type: Item.Type) throws -> [Item] {
        let realm = try Realm()
        return Array(realm.objects(Item.self))
    }
    
    func load<Item : Object, KeyType>(_ type: Item.Type, forPrimaryKey key: KeyType) throws -> Item {
        let realm = try Realm()
        
        if let result = realm.object(ofType: Item.self, forPrimaryKey: key) {
            return result
        } else {
            throw FailureError.unknown(error: "Load CharacterDetail from database by characterID = \(key) failed!")
        }
    }
}
