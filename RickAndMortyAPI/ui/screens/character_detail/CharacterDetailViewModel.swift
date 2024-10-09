//
//  CharacterDetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 09.10.2024.
//

import Foundation

class CharacterDetailViewModel : ViewModel<CharacterDetailViewState> {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor, characterId: Int) {
        self.interactor = interactor
        super.init(viewState: CharacterDetailViewState(characterId: characterId))
    }
}
