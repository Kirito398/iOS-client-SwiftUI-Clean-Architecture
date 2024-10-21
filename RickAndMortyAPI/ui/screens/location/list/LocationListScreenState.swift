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
}
