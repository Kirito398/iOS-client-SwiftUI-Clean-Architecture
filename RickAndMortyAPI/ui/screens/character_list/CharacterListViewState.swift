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
    private(set) var currentPage: Int = 0
    private(set) var pagesNumber: Int = 1
}

extension CharacterListViewState {
    mutating func updateCharacterList(_ list: [CharacterList.CharacterInfo]) {
        self.characterList = list
    }
    
    mutating func setPagesNumber(_ pagesNumber: Int) {
        self.pagesNumber = pagesNumber
    }
    
    mutating func setCurrentPage(_ currentPage: Int) {
        self.currentPage = currentPage
    }
}
