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
            print("Fetched data: \(result)")
            self?.updateName(result: result)
        }
    }
    
    private func updateName(result: CharacterList) {
        mutate { state in
            state.updateName(result.list.first?.name ?? "Default")
        }
    }
    
    deinit {
        print("deleted")
    }
}
