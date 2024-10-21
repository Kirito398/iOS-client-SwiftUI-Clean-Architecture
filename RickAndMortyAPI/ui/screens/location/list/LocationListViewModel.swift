//
//  LocationViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

class LocationListViewModel : ViewModel<LocationListScreenState> {
    
    init() {
        super.init(viewState: LocationListScreenState())
    }
}
