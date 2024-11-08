//
//  CharacterMainScreenViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

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
