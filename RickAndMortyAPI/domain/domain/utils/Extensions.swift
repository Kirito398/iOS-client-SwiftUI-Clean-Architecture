//
//  Extensions.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 30.10.2024.
//

import Foundation

extension Array where Element : Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for item in self {
            if result.contains(item) == false {
                result.append(item)
            }
        }
        
        return result
    }
    
    func addWithoutDuplicates(_ list: [Element]) -> [Element] {
        var newList = self
        
        for item in list {
            if newList.contains(item) == false {
                newList.append(item)
            }
        }
        
        return newList
    }
}
