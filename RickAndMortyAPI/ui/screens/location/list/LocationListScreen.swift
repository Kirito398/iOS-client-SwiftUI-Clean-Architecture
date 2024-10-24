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
    
    private var onItemTapListener: ((LocationDetailUI) -> Void)?
    
    init(
        viewModel: LocationListViewModel,
        onItemTapListener: ((LocationDetailUI) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.onItemTapListener = onItemTapListener
    }
    
    var content: some View {
        PagingScrollView(
            isRefreshing: viewState.showProgressView,
            items: viewState.locationList
        ) { locationDetail in
            LocationListItemView(locationDetail: locationDetail)
                .onTapGesture {
                    onItemTapListener?.self(locationDetail)
                }
        }
        .onNewPage {
            viewModel.loadNextPage()
        }
        .refreshable {
            viewModel.refreshLocationList()
        }
        .scrollIndicators(.hidden)
    }
}

struct LocationListItemView: View {
    let locationDetail: LocationDetailUI
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(locationDetail.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(locationDetail.type)
                .titled("Type:", fontWeight: .medium)
            
            Text(locationDetail.dimension)
                .titled("Dimension:", fontWeight: .medium)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(Dimensions.defaultPadding)
        .background(Color.customGray)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
    }
}

#Preview {
    LocationListScreen(
        viewModel: RootComponent().uiComponent.locationListViewModel
    )
    .appTheme()
}
