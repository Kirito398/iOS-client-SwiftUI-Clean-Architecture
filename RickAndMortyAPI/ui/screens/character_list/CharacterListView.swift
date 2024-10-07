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
        ScrollView {
            ForEach(viewState.characterList) { character in
                CharacterInfoView(character: character)
            }
        }
        .padding()
        .background(Color.darkGray)
        .onAppear() {
            viewModel.fetchCharacterList()
        }
    }
}

//#Preview {
//    CharacterListView()
//}
