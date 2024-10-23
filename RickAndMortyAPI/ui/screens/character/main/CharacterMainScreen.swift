//
//  CharacterMainScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 15.10.2024.
//

import SwiftUI

struct CharacterMainScreen: AppView {
    typealias ViewStateType = CharacterMainScreenState
    
    @State var viewModel: CharacterMainViewModel
    
    private var uiComponent: UiComponentProtocol
    private var characterListViewModel: CharacterListViewModel
    
    @Namespace
    private var geometryEffectNamespace
    
    init(uiComponent: UiComponentProtocol) {
        self.viewModel = uiComponent.characterMainViewModel
        self.uiComponent = uiComponent
        self.characterListViewModel = uiComponent.characterListViewModel
    }
    
    var content: some View {
        ZStack {
            //TODO: Trouble with matchedGeometryEffect (double views)
            characterListView
                    .zIndex(1)
                    .opacity(viewState.currentScreen.isDetail() ? 0 : 1)
            
            if case .Detail(_) = viewState.currentScreen {
                characterDetailView
                    .zIndex(2)
            }
        }
        .onDisappear {
            showCharacterList()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var characterListView: some View {
        CharacterListScreen(
            viewModel: characterListViewModel,
            geometryEffectNamespace: geometryEffectNamespace
        ) { characterDetail in
            showCharacterDetail(by: characterDetail)
        }
    }
    
    @ViewBuilder
    private var characterDetailView: some View {
        ZStack(alignment: .topLeading) {
            if case .Detail(let characterDetail) = viewState.currentScreen {
                CharacterDetailScreen(
                    viewModel: uiComponent.getCharacterDetailViewModel(
                        characterDetail: characterDetail
                    ),
                    geometryEffectNamespace: geometryEffectNamespace
                )
                .zIndex(1)
            }
            
            backButton
                .zIndex(2)
        }
    }
    
    private var backButton: some View {
        Button {
            showCharacterList()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.darkGray)
                    .frame(
                        width: Dimensions.circleButtonSize,
                        height: Dimensions.circleButtonSize
                    )
                
                Image(systemName: "chevron.backward.circle")
                    .resizable()
                    .foregroundColor(Color.orange)
                    .frame(
                        width: Dimensions.circleButtonSize,
                        height: Dimensions.circleButtonSize
                    )
            }
        }
        .padding(Dimensions.actionButtonPadding)
    }
    
    private func showCharacterDetail(by characterDetail: CharacterDetailUI) {
        withAnimation(.snappy(duration: 0.8)) {
            viewModel.showCharacterDetail(by: characterDetail)
        }
    }
    
    private func showCharacterList() {
        withAnimation(.snappy(duration: 0.8)) {
            viewModel.showCharacterList()
        }
    }
}

#Preview {
    CharacterMainScreen(uiComponent: RootComponent().uiComponent)
        .appTheme()
}
