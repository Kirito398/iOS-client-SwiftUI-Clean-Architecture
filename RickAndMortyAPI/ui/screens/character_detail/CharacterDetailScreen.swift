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
        HStack {
            if let characterDetail = viewState.characterDetail {
                CharacterDetailView(characterDetail: characterDetail)
            } else {
                ProgressView()
                    .foregroundColor(Color.lightOrange)
            }
        }.onAppear() {
            viewModel.fetchCharacterDetail()
        }
        .frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .background(Color.darkGray)
        .foregroundColor(Color.lightGray)
    }
}

struct CharacterDetailView : View {
    var characterDetail: CharacterDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            characterAvatar
            
            Text("Name: \(characterDetail.name)")
        }
    }
    
    var characterAvatar: some View {
        AsyncImage(url: URL(string: characterDetail.image)) { phase in
            if let image: Image = phase.image {
                image
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    CharacterDetailScreen(
        viewModel: CharacterDetailViewModel(
            interactor: RootComponent().domainComponent.rickAndMortyInteractor,
            characterId: 1
        )
    )
}
