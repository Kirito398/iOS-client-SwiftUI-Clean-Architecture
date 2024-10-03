//
//  BaseView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

protocol AppView: View {
    associatedtype ViewStateType : ViewState
    associatedtype ViewModelType : ViewModel<ViewStateType>
    associatedtype Content : View
    
    var viewModel : ViewModelType { get set }
    
    @ViewBuilder @MainActor var content : Self.Content { get }
}

extension AppView {
    
    var viewState: ViewStateType {
        viewModel.viewState
    }
    
    @MainActor
    var body: some View {
        content
            .failureAlert(
                of: viewState.errorMessage,
                actions: { failure in
                    Button("OK", role: .cancel) {
                        viewModel.clearErrorMessage()
                    }
                }
            )
    }
}
