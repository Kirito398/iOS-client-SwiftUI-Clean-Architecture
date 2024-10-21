//
//  CharacterDetailViewState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 09.10.2024.
//

import Foundation

struct CharacterDetailViewState : ViewState {
    internal var errorMessage: FailureError?
    internal var showProgressView: Bool = false
    private(set) var characterId: Int
    private(set) var characterDetail: CharacterDetailUI? = CharacterDetailUI.sample
}

extension CharacterDetailViewState {
    mutating func setCharacterDetail(by detail: CharacterDetailUI) {
        characterDetail = detail
    }
}
