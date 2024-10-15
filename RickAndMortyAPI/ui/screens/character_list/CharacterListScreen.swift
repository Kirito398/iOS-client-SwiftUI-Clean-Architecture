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
    @EnvironmentObject var router: Router
    
    var content: some View {
        PagingScrollView(items: viewState.characterList) { character in
            NavigationLink(value: Destination.CharacterDetail(characterId: character.id)) {
                CharacterInfoView(character: character)
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
