//
//  CharacterListScreenState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import Foundation

struct CharacterListViewState : ViewState {
    internal var errorMessage: FailureError?
    private(set) var characterList: [CharacterList.CharacterInfo] = []
}

extension CharacterListViewState {
    mutating func updateCharacterList(_ list: [CharacterList.CharacterInfo]) {
        self.characterList = list
    }
}
