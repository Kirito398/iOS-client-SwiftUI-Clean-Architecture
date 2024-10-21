//
//  CharacterListScreenState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import Foundation

struct CharacterListScreenState : ViewState {
    internal var errorMessage: FailureError?
    internal var showProgressView: Bool = false
    private(set) var characterList: [CharacterDetailUI] = []
    private(set) var currentPage: Int = 0
    private(set) var pagesNumber: Int = 1
}

extension CharacterListScreenState {
    mutating func updateCharacterList(_ list: [CharacterDetailUI]) {
        self.characterList = list
    }
    
    mutating func setPagesNumber(_ pagesNumber: Int) {
        self.pagesNumber = pagesNumber
    }
    
    mutating func setCurrentPage(_ currentPage: Int) {
        self.currentPage = currentPage
    }
}
