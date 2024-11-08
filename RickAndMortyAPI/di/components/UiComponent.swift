//
//  UiComponent.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation
import NeedleFoundation
import domain
import ui

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
    
    var locationListViewModel: LocationListViewModel {
        LocationListViewModel(interactor: dependency.rickAndMortyInteractor)
    }
    
    var locationMainViewModel: LocationMainViewModel {
        LocationMainViewModel()
    }
    
    
    func getCharacterDetailViewModel(characterId: Int) -> CharacterDetailViewModel {
        CharacterDetailViewModel(interactor: dependency.rickAndMortyInteractor, characterId: characterId)
    }
    
    func getCharacterDetailViewModel(characterDetail: CharacterDetailUI) -> CharacterDetailViewModel {
        CharacterDetailViewModel(interactor: dependency.rickAndMortyInteractor, characterDetail: characterDetail)
    }
    
    func locationDetailViewModel(locationId: Int) -> LocationDetailViewModel {
        LocationDetailViewModel(interactor: dependency.rickAndMortyInteractor, locationId: locationId)
    }
    
    func locationDetailViewModel(locationDetail: LocationDetailUI) -> LocationDetailViewModel {
        LocationDetailViewModel(interactor: dependency.rickAndMortyInteractor, locationDetail: locationDetail)
    }
}
