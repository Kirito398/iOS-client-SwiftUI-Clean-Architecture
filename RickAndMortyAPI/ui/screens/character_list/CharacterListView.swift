//
//  CharacterListView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

struct CharacterListView: AppView {
    typealias ViewStateType = CharacterListViewState
    
    internal var viewModel: CharacterListViewModel
    
    var content: some View {        
        PagingScrollView(items: viewState.characterList) { character in
            CharacterInfoView(character: character)
        }
        .onNewPage {
            viewModel.loadNextPage()
        }
        .padding(Dimensions.defaultPading)
        .background(Color.darkGray)
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    CharacterListView()
//}
