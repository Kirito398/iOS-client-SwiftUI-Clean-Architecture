//
//  CharacterMainScreenState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 21.10.2024.
//

import Foundation

struct CharacterMainScreenState : ViewState {
    internal var errorMessage: FailureError?
    internal var showProgressView: Bool = false
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
