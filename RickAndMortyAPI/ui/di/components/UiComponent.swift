//
//  UiComponent.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation
import NeedleFoundation

protocol UiComponentProtocol {
    var navigationRouter: Router { get }
    var characterListViewModel: CharacterListViewModel { get }
    var characterMainViewModel: CharacterMainViewModel { get }
    
    func getCharacterDetailViewModel(characterId: Int) -> CharacterDetailViewModel
    func getCharacterDetailViewModel(characterDetail: CharacterDetailUI) -> CharacterDetailViewModel
}

protocol UiComponentDependency : Dependency {
    var rickAndMortyInteractor: RickAndMortyInteractor { get }
}

final class UiComponent : Component<UiComponentDependency>, UiComponentProtocol {
    var navigationRouter: Router {
        Router()
    }
    
    var characterListViewModel: CharacterListViewModel {
        CharacterListViewModel(interactor: dependency.rickAndMortyInteractor)
    }
    
    var characterMainViewModel: CharacterMainViewModel {
        CharacterMainViewModel()
    }
    
    func getCharacterDetailViewModel(characterId: Int) -> CharacterDetailViewModel {
        CharacterDetailViewModel(interactor: dependency.rickAndMortyInteractor, characterId: characterId)
    }
    
    func getCharacterDetailViewModel(characterDetail: CharacterDetailUI) -> CharacterDetailViewModel {
        CharacterDetailViewModel(interactor: dependency.rickAndMortyInteractor, characterDetail: characterDetail)
    }
}
