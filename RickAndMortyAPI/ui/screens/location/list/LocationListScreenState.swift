//
//  LocationListScreenState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

struct LocationListScreenState : ViewState {
    internal var showProgressView: Bool = false
    internal var errorMessage: FailureError?
    private(set) var locationList: [LocationDetailUI] = []
    private(set) var currentPage: Int = 0
    private(set) var pagesNumber: Int = 1
}

extension LocationListScreenState {
    mutating func updateLocationList(_ list: [LocationDetailUI]) {
        self.locationList = list
    }
    
    mutating func setCurrentPage(_ page: Int) {
        self.currentPage = page
    }
    
    mutating func setPagesNumber(_ number: Int) {
        self.pagesNumber = number
    }
}
