//
//  CharacterListUI.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 16.10.2024.
//

import Foundation

struct CharacterListUI {
    let info: Info
    let list: [CharacterDetailUI]
    
    struct Info {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
}

extension CharacterList {
    func mapToUIModel() -> CharacterListUI {
        CharacterListUI(
            info: self.info.mapToUIModel(),
            list: self.list.map{ item in
                item.mapToUIModel()
            }
        )
    }
}

extension CharacterList.Info {
    func mapToUIModel() -> CharacterListUI.Info {
        CharacterListUI.Info(count: self.count, pages: self.pages, next: self.next, prev: self.prev)
    }
}
