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
    private var avatarNamespace
    
    init(uiComponent: UiComponentProtocol) {
        self.viewModel = uiComponent.characterMainViewModel
        self.uiComponent = uiComponent
        self.characterListViewModel = uiComponent.characterListViewModel
    }
    
    var content: some View {
        ZStack(alignment: .topLeading) {
            
            switch viewState.currentScreen {
            case .List:
                CharacterListScreen(
                    viewModel: characterListViewModel,
                    avatarNamespace: avatarNamespace
                ) { characterDetail in
                    showCharacterDetail(by: characterDetail)
                }
                
            case.Detail(let characterDetail):
                CharacterDetailScreen(
                    viewModel: uiComponent.getCharacterDetailViewModel(
                        characterDetail: characterDetail
                    ),
                    avatarNamespace: avatarNamespace
                )
                .zIndex(1)
            }
            
            Button {
                showCharacterList()
            } label: {
                Text("Back")
            }
            .zIndex(2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func showCharacterDetail(by characterDetail: CharacterDetailUI) {
        withAnimation() {
            viewModel.showCharacterDetail(by: characterDetail)
        }
    }
    
    private func showCharacterList() {
        withAnimation() {
            viewModel.showCharacterList()
        }
    }
}

#Preview {
    CharacterMainScreen(uiComponent: RootComponent().uiComponent)
}

class CharacterMainViewModel : ViewModel<CharacterMainScreenState> {
    init() {
        super.init(viewState: CharacterMainScreenState())
    }
    
    func showCharacterDetail(by characterDetail: CharacterDetailUI) {
        mutate { viewState in
            viewState.setCurrentScreen(
                screenType: CharacterMainScreenState.ScreenType.Detail(
                    characterDetail: characterDetail
                )
            )
        }
    }
    
    func showCharacterList() {
        mutate { viewState in
            viewState.setCurrentScreen(
                screenType: CharacterMainScreenState.ScreenType.List
            )
        }
    }
}

struct CharacterMainScreenState : ViewState {
    var errorMessage: FailureError?
    var currentScreen: ScreenType = ScreenType.List
    
    enum ScreenType {
        case List
        case Detail(characterDetail: CharacterDetailUI)
        
        func isDetail() -> Bool {
            switch self {
            case .List: false
            case .Detail(_): true
            }
        }
    }
}

extension CharacterMainScreenState {
    mutating func setCurrentScreen(screenType: ScreenType) {
        currentScreen = screenType
    }
}


