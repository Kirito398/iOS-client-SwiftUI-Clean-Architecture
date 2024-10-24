//
//  LocationDetailViewState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 23.10.2024.
//

import Foundation

struct LocationDetailViewState : ViewState {
    internal var errorMessage: FailureError?
    internal var showProgressView: Bool = false
    private(set) var locationId: Int
    private(set) var locationDetail: LocationDetailUI?
}

extension LocationDetailViewState {
    mutating func setLocationDetail(_ locationDetail: LocationDetailUI) {
        self.locationDetail = locationDetail
    }
}
