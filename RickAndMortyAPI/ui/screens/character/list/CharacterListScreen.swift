//
//  CharacterListView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

struct CharacterListScreen: AppView {
    typealias ViewStateType = CharacterListScreenState
    
    @State internal var viewModel: CharacterListViewModel
    
    private var geometryEffectNamespace: Namespace.ID?
    private var onItemTapListener: ((CharacterDetailUI) -> Void)?
    
    init(
        viewModel: CharacterListViewModel,
        geometryEffectNamespace: Namespace.ID? = nil,
        onItemTapListener: ((CharacterDetailUI) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.geometryEffectNamespace = geometryEffectNamespace
        self.onItemTapListener = onItemTapListener
    }
    
    var content: some View {
        PagingScrollView(
            isRefreshing: viewState.showProgressView,
            items: viewState.characterList
        ) { character in
            CharacterInfoItemView(
                character: character,
                geometryEffectNamespace: geometryEffectNamespace
            )
            .onTapGesture {
                onItemTapListener?.self(character)
            }
        }
        .onNewPage {
            viewModel.loadNextPage()
        }
        .refreshable {
            viewModel.refreshCharacterList()
        }
        .padding(Dimensions.defaultPadding)
        .background(Color.darkGray)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CharacterListScreen(
        viewModel: RootComponent().uiComponent.characterListViewModel
    )
}
