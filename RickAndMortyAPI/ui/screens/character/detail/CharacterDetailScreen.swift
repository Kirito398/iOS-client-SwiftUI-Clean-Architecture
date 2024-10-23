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
    
    private var geometryEffectNamespace: Namespace.ID?
    
    init(
        viewModel: CharacterDetailViewModel,
        geometryEffectNamespace: Namespace.ID? = nil
    ) {
        self.viewModel = viewModel
        self.geometryEffectNamespace = geometryEffectNamespace
    }
    
    var content: some View {
        RefreshableScrollView(
            isRefreshing: viewState.showProgressView,
            progressView: progressView
        ) {
            if let characterDetail = viewState.characterDetail {
                CharacterDetailView(
                    characterDetail: characterDetail,
                    geometryEffectNamespace: geometryEffectNamespace
                )
            }
        }
        .refreshable {
            viewModel.fetchCharacterDetail()
        }
        .onAppear() {
            viewModel.fetchCharacterDetail()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    private var progressView: some View {
        ProgressView()
            .tint(Color.lightOrange)
            .padding()
    }
}

private struct CharacterDetailView : View {
    var characterDetail: CharacterDetailUI
    var geometryEffectNamespace: Namespace.ID?
    
    var body: some View {
        VStack(alignment: .leading) {
            avatar.zIndex(2)
            detail
        }
    }
    
    private var avatar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                avatarImage
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.width
                    )
            }
        }
        .scaledToFit()
    }
    
    private var avatarImage: some View {
        CharacterAvatarView(characterAvatar: characterDetail.avatar)
            .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
            .matchedGeometryEffectIfNotNil(
                id: characterDetail.geometryMatchedIds.avatar,
                namespace: geometryEffectNamespace
            )
    }
    
    private var detail: some View {
        VStack(alignment: .leading) {
            detailTitle
            
            Text(characterDetail.species)
                .font(.title3)
                .titled("Species: ")
            
            Text(characterDetail.gender.string)
                .font(.title3)
                .titled("Gender:")

            Text(characterDetail.origin.name)
                .font(.title3)
                .titled("First seen in:")

            Text(characterDetail.location.name)
                .font(.title3)
                .titled("Last known location:")
        }
        .padding()
        .background(Color.customGray)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
        .matchedGeometryEffectIfNotNil(
            id: characterDetail.geometryMatchedIds.detailBlock,
            namespace: geometryEffectNamespace
        )
    }
    
    private var detailTitle: some View {
        HStack {
            Text(characterDetail.name)
                .font(.title)
                .fontWeight(.bold)
                .matchedGeometryEffectIfNotNil(
                    id: characterDetail.geometryMatchedIds.name,
                    namespace: geometryEffectNamespace
                )
            
            Spacer()
            
            statusMark
        }
        .frame(maxWidth: .infinity)
    }
    
    private var statusMark: some View {
        HStack {
            Circle()
                .fill(characterDetail.status.color)
                .frame(
                    maxWidth: Dimensions.defaultCircusMarkSize,
                    maxHeight: Dimensions.defaultCircusMarkSize
                )
                
            Text(characterDetail.status.toString())
                .font(.title3)
        }
        .matchedGeometryEffectIfNotNil(
            id: characterDetail.geometryMatchedIds.status,
            namespace: geometryEffectNamespace
        )
    }
}

#Preview {
    CharacterDetailScreen(
        viewModel: CharacterDetailViewModel(
            interactor: RootComponent().domainComponent.rickAndMortyInteractor,
            characterId: 1
        )
    )
    .appTheme()
}
