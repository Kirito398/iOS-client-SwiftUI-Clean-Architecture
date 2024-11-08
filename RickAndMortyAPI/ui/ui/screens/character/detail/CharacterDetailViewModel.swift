//
//  CharacterDetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 09.10.2024.
//

import Foundation
import domain

class CharacterDetailViewModel : ViewModel<CharacterDetailViewState> {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor, characterId: Int) {
        self.interactor = interactor
        super.init(viewState: CharacterDetailViewState(characterId: characterId))
    }
    
    init(interactor: RickAndMortyInteractor, characterDetail: CharacterDetailUI) {
        self.interactor = interactor
        super.init(viewState: CharacterDetailViewState(characterId: characterDetail.id, characterDetail: characterDetail))
    }
    
    func fetchCharacterDetail() {
        let characterId = viewState.characterId
        doTask { [weak self] in
            await self?.interactor.fetchCharacterDetail(by: characterId)
        } onResult: { [weak self] detail in
            self?.updateCharacterDetail(by: detail.mapToUIModel())
        }
    }
    
    private func updateCharacterDetail(by detail: CharacterDetailUI) {
        mutate { state in
            state.setCharacterDetail(by: detail)
        }
    }
}
