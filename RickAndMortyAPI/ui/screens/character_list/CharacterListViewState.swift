//
//  CharacterListScreenState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import Foundation

struct CharacterListViewState : ViewState {
    internal var errorMessage: FailureError?
    private(set) var name: String = ""
}

extension CharacterListViewState {
    mutating func updateName(_ name: String) {
        self.name = name
    }
}
