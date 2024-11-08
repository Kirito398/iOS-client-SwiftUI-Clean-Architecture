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
    
    @State
    private var text: String = ""
    
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
        VStack(spacing: .zero) {
            SearchBar(
                label: viewState.filter.name
            ) { inputText in
                withAnimation {
                    viewModel.search(by: inputText)
                }
            }
            
            if viewState.characterList.isEmpty {
                emptyList
                    .onAppear() {
                        viewModel.refreshCharacterList()
                    }
            } else {
                characterList
            }
        }
    }
    
    private var emptyList: some View {
        VStack(alignment: .center) {
            if viewState.showProgressView {
                loadingProgressView
            } else {
                Text("No data")
                    .fontWeight(.bold)
                
               refreshButton
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
    
    private var characterList: some View {
        PagingScrollView(
            isRefreshing: viewState.showProgressView,
            hasNextPage: viewState.hasNextPage,
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
        .scrollIndicators(.hidden)
    }
    
    private var loadingProgressView: some View {
        ProgressView()
            .tint(Color.lightOrange)
            .padding()
    }
    
    private var refreshButton: some View {
        Button {
            viewModel.refreshCharacterList()
        } label: {
            HStack {
                Text("Refresh")
                Image(systemName: "arrow.clockwise")
            }
            .foregroundColor(Color.lightOrange)
        }
    }
}

#Preview {
    CharacterListScreen(
        viewModel: RootComponent().uiComponent.characterListViewModel
    )
    .appTheme()
}
