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
}
