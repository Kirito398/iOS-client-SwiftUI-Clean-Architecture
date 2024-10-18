//
//  CharacterListViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation
import Observation

class CharacterListViewModel : ViewModel<CharacterListScreenState> {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor) {
        self.interactor = interactor
        super.init(viewState: CharacterListScreenState())
    }
    
    func loadNextPage() {
        let nextPageNumber = viewState.currentPage + 1
        
        if nextPageNumber <= viewState.pagesNumber {
            doTask { [weak self] in
                try await self?.interactor.fetchCharacterList(by: nextPageNumber).mapToUIModel()
            } onResult: { [weak self] result in
                self?.updateCharacterListWithPageNumber(by: result, with: nextPageNumber)
            }
        }
    }
    
    private func updateCharacterListWithPageNumber(
        by listInfo: CharacterListUI,
        with pageNumber: Int
    ) {
        mutate { state in
            state.updateCharacterList(viewState.characterList + listInfo.list)
            state.setCurrentPage(pageNumber)
            state.setPagesNumber(listInfo.info.pages)
        }
    }
    
    deinit {
        "Deleted".debugLog()
    }
}