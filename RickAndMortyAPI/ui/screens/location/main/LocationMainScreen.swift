//
//  LocationMainScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 23.10.2024.
//

import SwiftUI

struct LocationMainScreen: AppView {
    typealias ViewStateType = LocationMainViewState
    internal var viewModel: LocationMainViewModel
    
    private let uiComponent: UiComponentProtocol
    private let locationListViewModel: LocationListViewModel
    
    init(uiComponent: UiComponentProtocol) {
        self.uiComponent = uiComponent
        self.viewModel = uiComponent.locationMainViewModel
        self.locationListViewModel = uiComponent.locationListViewModel
    }
    
    var content: some View {
        ZStack {
            list.opacity(viewState.currentScreen.isDetail() ? 0 : 1)
            
            if viewState.currentScreen.isDetail() {
                detail
            }
        }
    }
    
    private var list: some View {
        LocationListScreen(viewModel: locationListViewModel) { locationDetail in
            viewModel.setCurrentScreen(.Detail(locationDetail: locationDetail))
        }
    }
    
    @ViewBuilder
    private var detail: some View {
        VStack(alignment: .leading, spacing: .zero) {
            BackButton {
                viewModel.setCurrentScreen(.List)
            }
            
            if case .Detail(let locationDetail) = viewState.currentScreen {
                LocationDetailScreen(
                    viewModel: uiComponent.locationDetailViewModel(
                        locationDetail: locationDetail
                    )
                )
            }
        }
    }
}

class LocationMainViewModel : ViewModel<LocationMainViewState> {
    init() {
        super.init(viewState: LocationMainViewState())
    }
    
    func setCurrentScreen(_ screen: LocationMainViewState.ScreenType) {
        mutate { viewState in
            viewState.setCurrentScreen(screen)
        }
    }
}

struct LocationMainViewState : ViewState {
    internal var showProgressView: Bool = false
    internal var errorMessage: FailureError?
    private(set) var currentScreen: ScreenType = .List
    
    enum ScreenType {
        case List
        case Detail(locationDetail: LocationDetailUI)
        
        func isDetail() -> Bool {
            switch self {
            case .List: false
            case .Detail(_): true
            }
        }
    }
}

extension LocationMainViewState {
    mutating func setCurrentScreen(_ screen: ScreenType) {
        self.currentScreen = screen
    }
}

#Preview {
    LocationMainScreen(
        uiComponent: RootComponent().uiComponent
    )
    .appTheme()
}
