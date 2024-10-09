//
//  CharacterDetailScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 08.10.2024.
//

import SwiftUI

struct CharacterDetailScreen : AppView {
    typealias ViewStateType = CharacterDetailViewState
    @State internal var viewModel: CharacterDetailViewModel
    
    var content: some View {
        Text("Name: \(viewState.characterId)")
    }
}
