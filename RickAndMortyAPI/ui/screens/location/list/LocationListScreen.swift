//
//  LocationListScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import SwiftUI

struct LocationListScreen: AppView {
    typealias ViewStateType = LocationListScreenState
    internal var viewModel: LocationListViewModel
    
    var content: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LocationListScreen(viewModel: RootComponent().uiComponent.locationListViewModel)
}
