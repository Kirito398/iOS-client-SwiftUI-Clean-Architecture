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
    
    private let geometryMatchedEffectNamespace: Namespace.ID?
    private let onItemTapListener: ((LocationDetailUI) -> Void)?
    
    init(
        viewModel: LocationListViewModel,
        geometryMatchedEffectNamespace: Namespace.ID? = nil,
        onItemTapListener: ((LocationDetailUI) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.geometryMatchedEffectNamespace = geometryMatchedEffectNamespace
        self.onItemTapListener = onItemTapListener
    }
    
    var content: some View {
        if viewState.locationList.isEmpty {
            emptyList
                .onAppear() {
                    viewModel.refreshLocationList()
                }
        } else {
            locationList
        }
    }
    
    private var emptyList: some View {
        VStack(alignment: .center) {
            if viewState.showProgressView {
                loadingProgressView
            } else {
                Text("No data")
                    .fontWeight(.bold)
                
               refreshButton
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
    
    var locationList: some View {
        PagingScrollView(
            isRefreshing: viewState.showProgressView,
            hasNextPage: viewState.hasNextPage,
            items: viewState.locationList
        ) { locationDetail in
            LocationListItemView(
                locationDetail: locationDetail,
                geometryMatchedEffectNamespace: geometryMatchedEffectNamespace
            )
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
    
    private var loadingProgressView: some View {
        ProgressView()
            .tint(Color.lightOrange)
            .padding()
    }
    
    private var refreshButton: some View {
        Button {
            viewModel.refreshLocationList()
        } label: {
            HStack {
                Text("Refresh")
                Image(systemName: "arrow.clockwise")
            }
            .foregroundColor(Color.lightOrange)
        }
    }
}

struct LocationListItemView: View {
    private let locationDetail: LocationDetailUI
    private let geometryMatchedEffectNamespace: Namespace.ID?
    
    init(
        locationDetail: LocationDetailUI,
        geometryMatchedEffectNamespace: Namespace.ID? = nil
    ) {
        self.locationDetail = locationDetail
        self.geometryMatchedEffectNamespace = geometryMatchedEffectNamespace
    }
    
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
        .matchedGeometryEffectIfNotNil(
            id: locationDetail.geometryMatchedIds.block,
            namespace: geometryMatchedEffectNamespace
        )
    }
}

#Preview {
    LocationListScreen(
        viewModel: RootComponent().uiComponent.locationListViewModel
    )
    .appTheme()
}
