//
//  CharacterListViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation
import Observation

class CharacterListViewModel : ViewModel<CharacterListViewState> {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor) {
        self.interactor = interactor
        super.init(viewState: CharacterListViewState())
    }
    
    func fetchCharacterList() {
        doTask(interactor.fetchCharacterList.self) { [weak self] result in
            self?.updateCharacterList(list: result.list)
        }
    }
    
    private func updateCharacterList(list: [CharacterList.CharacterInfo]) {
        mutate { state in
            state.updateCharacterList(list)
        }
    }
    
    deinit {
        "Deleted".debugLog()
    }
}
