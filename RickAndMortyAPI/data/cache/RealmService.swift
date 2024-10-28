//
//  RealmService.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 25.10.2024.
//

import Foundation
import RealmSwift

final class RealmService {
    private let realm = try! Realm()
    
    func writeAll(list: [Object]) throws {
        try realm.write {
            list.forEach { item in
                realm.add(item, update: .all)
            }
        }
    }
    
    func write(object: Object) throws {
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func loadAll<Item : Object>(_ type: Item.Type) -> [Item] {
        return Array(realm.objects(Item.self))
    }
    
    func load<Item : Object, KeyType>(forPrimaryKey key: KeyType) -> Item? {
        return realm.object(ofType: Item.self, forPrimaryKey: key)
    }
}
