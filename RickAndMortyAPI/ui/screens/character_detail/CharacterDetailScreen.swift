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
    
    private var avatarNamespace: Namespace.ID?
    
    init(viewModel: CharacterDetailViewModel, avatarNamespace: Namespace.ID? = nil) {
        self.viewModel = viewModel
        self.avatarNamespace = avatarNamespace
    }
    
    var content: some View {
        HStack {
            if let characterDetail = viewState.characterDetail {
                CharacterDetailView(
                    characterDetail: characterDetail,
                    avatarNamespace: avatarNamespace
                )
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

private struct CharacterDetailView : View {
    var characterDetail: CharacterDetail
    var avatarNamespace: Namespace.ID?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                characterAvatar
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.width
                    )
                
                Text("Name: \(characterDetail.name)")
                    .matchedGeometryEffectIfNotNil(
                        id: "name_\(characterDetail.id)",
                        namespace: avatarNamespace
                    )
            }
        }
    }
    
    var characterAvatar: some View {
        AsyncImage(url: URL(string: characterDetail.image)) { phase in
            if let image: Image = phase.image {
                image
                    .resizable(resizingMode: .stretch)
                    //.aspectRatio(contentMode: .fit)
            }
        }
        .matchedGeometryEffectIfNotNil(
            id: characterDetail.id,
            namespace: avatarNamespace
        )
        .transition(.asymmetric(insertion: .identity, removal: .identity))
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
