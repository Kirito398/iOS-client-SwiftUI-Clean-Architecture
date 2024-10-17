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
    
    private var avatarNamespace: Namespace.ID?
    private var onItemTapListener: ((CharacterDetailUI) -> Void)?
    
    init(
        viewModel: CharacterListViewModel,
        avatarNamespace: Namespace.ID? = nil,
        onItemTapListener: ((CharacterDetailUI) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.avatarNamespace = avatarNamespace
        self.onItemTapListener = onItemTapListener
    }
    
    var content: some View {
        PagingScrollView(items: viewState.characterList) { character in
            CharacterInfoItemView(
                character: character,
                avatarNamespace: avatarNamespace
            )
            .onTapGesture {
                onItemTapListener?.self(character)
            }
        }
        .onNewPage {
            viewModel.loadNextPage()
        }
        .padding(Dimensions.defaultPading)
        .background(Color.darkGray)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CharacterListScreen(
        viewModel: RootComponent().uiComponent.characterListViewModel
    )
}
