//
//  CharacterDetailViewState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 09.10.2024.
//

import Foundation

struct CharacterDetailViewState : ViewState {
    internal var errorMessage: FailureError?
    private(set) var characterId: Int
    private(set) var characterDetail: CharacterDetail? = CharacterDetail.sample
}

extension CharacterDetailViewState {
    mutating func setCharacterDetail(by detail: CharacterDetail) {
        characterDetail = detail
    }
}
