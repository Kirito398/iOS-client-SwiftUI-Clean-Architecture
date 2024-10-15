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
    
    func fetchCharacterDetail() {
        doTask { [weak self] in
            if let characterId = self?.viewState.characterId {
                try await self?.interactor.fetchCharacterDetail(by:characterId)
            } else {
                nil
            }
        } onResult: { [weak self] detail in
            self?.updateCharacterDetail(by: detail)
        }
    }
    
    private func updateCharacterDetail(by detail: CharacterDetail) {
        mutate { state in
            state.setCharacterDetail(by: detail)
        }
    }
}
