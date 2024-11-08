//
//  LocationDetailScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 23.10.2024.
//

import SwiftUI

struct LocationDetailScreen: AppView {
    typealias ViewStateType = LocationDetailViewState
    internal var viewModel: LocationDetailViewModel
    
    private let geometryMatchedEffectNamespace: Namespace.ID?
    
    init(
        viewModel: LocationDetailViewModel,
        geometryMatchedEffectNamespace: Namespace.ID? = nil
    ) {
        self.viewModel = viewModel
        self.geometryMatchedEffectNamespace = geometryMatchedEffectNamespace
    }
    
    var content: some View {
        RefreshableScrollView(
            isRefreshing: viewState.showProgressView,
            progressView: AppProgressView()
        ) {
            if let locationDetail = viewState.locationDetail {
                LocationDetailView(
                    locationDetail: locationDetail,
                    geometryMatchedEffectNamespace: geometryMatchedEffectNamespace
                )
            }
        }
        .refreshable {
            viewModel.fetchLocationDetail()
        }
        .onAppear() {
            viewModel.fetchLocationDetail()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct LocationDetailView : View {
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
            detailTitle
            
            Text(locationDetail.type)
                .font(.title3)
                .titled("Type: ")
            
            Text(locationDetail.dimension)
                .font(.title3)
                .titled("Dimension:")
        }
        .padding()
        .background(Color.customGray)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
        .matchedGeometryEffectIfNotNil(
            id: locationDetail.geometryMatchedIds.block,
            namespace: geometryMatchedEffectNamespace
        )
    }
    
    private var detailTitle: some View {
        Text(locationDetail.name)
            .font(.title)
            .fontWeight(.bold)
    }
}

#Preview {
    LocationDetailScreen(
        viewModel: RootComponent().uiComponent.locationDetailViewModel(
            locationId: 1
        )
    )
    .appTheme()
}
