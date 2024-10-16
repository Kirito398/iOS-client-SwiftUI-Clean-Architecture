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
    
    private var listID = UUID()
    
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
                .id(listID)
                
            case.Detail(let characterDetail):
                CharacterDetailScreen(
                    viewModel: uiComponent.getCharacterDetailViewModel(
                        characterDetail: characterDetail
                    ),
                    avatarNamespace: avatarNamespace
                )
            }
            
            Button {
                showCharacterList()
            } label: {
                Text("Back")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func showCharacterDetail(by characterDetail: CharacterDetail) {
        withAnimation(.linear(duration: 5)) {
            viewModel.showCharacterDetail(by: characterDetail)
        }
    }
    
    private func showCharacterList() {
        withAnimation(.linear(duration: 5)) {
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
    
    func showCharacterDetail(by characterDetail: CharacterDetail) {
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
        case Detail(characterDetail: CharacterDetail)
        
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


