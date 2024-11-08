//
//  CharacterListViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation
import Observation
import domain

class CharacterListViewModel : ViewModel<CharacterListScreenState> {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor) {
        self.interactor = interactor
        super.init(viewState: CharacterListScreenState())
    }
    
    func refreshCharacterList() {
        fetchCharacterList(
            with: viewState.filter,
            isForce: true
        )
    }
    
    func loadNextPage() {
        if viewState.hasNextPage {
            fetchCharacterList(
                by: viewState.currentPage + 1,
                with: viewState.filter
            )
        }
    }
    
    func search(by name: String) {
        mutate { state in
            state.clearCharacterList()
            state.updateFilter(name: name)
        }
        
        refreshCharacterList()
    }
    
    private func fetchCharacterList(
        by pageNumber: Int = 1,
        with filter: CharacterSearchFilter,
        isForce: Bool = false
    ) {
        doTask { [weak self] in
            await self?.interactor.fetchCharacterList(by: pageNumber, with: filter.mapToDomain())
        } onResult: { [weak self] result in
            self?.updateCharacterListWithPageNumber(
                by: result.mapToUIModel(),
                with: pageNumber,
                isForce: isForce
            )
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
            viewState.characterList.addWithoutDuplicates(listInfo.list)
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
