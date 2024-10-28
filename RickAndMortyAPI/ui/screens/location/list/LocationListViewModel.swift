//
//  LocationViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

class LocationListViewModel : ViewModel<LocationListScreenState> {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor) {
        self.interactor = interactor
        super.init(viewState: LocationListScreenState())
    }
    
    func refreshLocationList() {
        fetchLocationList(isForce: true)
    }
    
    func loadNextPage() {
        let nextPage = viewState.currentPage + 1
        
        if (nextPage <= viewState.pagesNumber) {
            fetchLocationList(by: nextPage)
        }
    }
    
    private func fetchLocationList(by page: Int = 1, isForce: Bool = false) {
        doTask { [weak self] in
            await self?.interactor.fetchLocationList(by: page)
        } onResult: { [weak self] result in
            self?.updateLocationListWithCurrentPage(
                result.mapToUiModel(),
                currentPage: page,
                isForce: isForce
            )
        }
    }
    
    private func updateLocationListWithCurrentPage(
        _ listInfo: LocationListUI,
        currentPage: Int,
        isForce: Bool = false
    ) {
        let newList = if isForce {
            listInfo.list
        } else {
            viewState.locationList + listInfo.list
        }
        
        mutate { viewState in
            viewState.updateLocationList(newList)
            viewState.setCurrentPage(currentPage)
            viewState.setPagesNumber(listInfo.info.pages)
        }
    }
}
