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
    
    func refreshCharacterList() {
        fetchCharacterList(isForce: true)
    }
    
    func loadNextPage() {
        let nextPageNumber = viewState.currentPage + 1
        
        if nextPageNumber <= viewState.pagesNumber {
            fetchCharacterList(by: nextPageNumber)
        }
    }
    
    private func fetchCharacterList(by pageNumber: Int = 1, isForce: Bool = false) {
        doTask { [weak self] in
            try await self?.interactor.fetchCharacterList(by: pageNumber).mapToUIModel()
        } onResult: { [weak self] result in
            self?.updateCharacterListWithPageNumber(by: result, with: pageNumber, isForce: isForce)
        }
    }
    
    private func updateCharacterListWithPageNumber(
        by listInfo: CharacterListUI,
        with pageNumber: Int,
        isForce: Bool = false
    ) {
        let newList = if isForce {
            listInfo.list
        } else {
            viewState.characterList + listInfo.list
        }
        
        mutate { state in
            state.updateCharacterList(newList)
            state.setCurrentPage(pageNumber)
            state.setPagesNumber(listInfo.info.pages)
        }
    }
    
    deinit {
        "Deleted".debugLog()
    }
}
