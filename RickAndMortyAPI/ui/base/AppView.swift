//
//  BaseView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

protocol AppView: View {
    associatedtype ViewModelType : ViewModel
    associatedtype Content : View
    
    var viewModel : ViewModelType { get set }
    
    @ViewBuilder @MainActor var content : Self.Content { get }
}

extension AppView {
    
    @MainActor
    var body: some View {
        content
            .failureAlert(
                of: viewModel.errorMessage,
                actions: { failure in
                    Button("OK", role: .cancel) { [weak viewModel] in
                        viewModel?.clearErrorMessage()
                    }
                }
            )
    }
}
