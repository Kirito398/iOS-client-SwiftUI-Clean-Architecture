//
//  LocationDetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 23.10.2024.
//

import Foundation

class LocationDetailViewModel : ViewModel<LocationDetailViewState> {
    init(interactor: RickAndMortyInteractor, locationId: Int) {
        self.interactor = interactor
        super.init(viewState: LocationDetailViewState(locationId: locationId))
    }
    
    init(interactor: RickAndMortyInteractor, locationDetail: LocationDetailUI) {
        self.interactor = interactor
        super.init(
            viewState: LocationDetailViewState(
                locationId: locationDetail.id,
                locationDetail: locationDetail
            )
        )
    }
    
    private var interactor: RickAndMortyInteractor
    
    func fetchLocationDetail() {
        let locationId = viewState.locationId
        doTask { [weak self] in
            await self?.interactor.fetchLocationDetail(by: locationId)
        } onResult: { [weak self] locationDetail in
            self?.updateLocationDetail(locationDetail: locationDetail.mapToUiModel())
        }
    }
    
    private func updateLocationDetail(locationDetail: LocationDetailUI) {
        mutate { viewState in
            viewState.setLocationDetail(locationDetail)
        }
    }
}
