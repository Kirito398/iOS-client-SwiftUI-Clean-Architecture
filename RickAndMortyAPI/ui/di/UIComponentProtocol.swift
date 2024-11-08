//
//  UIComponentProtocol.swift
//  ui
//
//  Created by Ilgiz Sultanbekov on 07.11.2024.
//

import Foundation

public protocol UiComponentProtocol {
    var navigationRouter: Router { get }
    
    var characterListViewModel: CharacterListViewModel { get }
    var characterMainViewModel: CharacterMainViewModel { get }
    
    var locationListViewModel: LocationListViewModel { get }
    var locationMainViewModel: LocationMainViewModel { get }
    
    func getCharacterDetailViewModel(characterId: Int) -> CharacterDetailViewModel
    func getCharacterDetailViewModel(characterDetail: CharacterDetailUI) -> CharacterDetailViewModel
    
    func locationDetailViewModel(locationId: Int) -> LocationDetailViewModel
    func locationDetailViewModel(locationDetail: LocationDetailUI) -> LocationDetailViewModel
}
