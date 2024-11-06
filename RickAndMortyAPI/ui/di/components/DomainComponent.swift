//
//  DomainComponent.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation
import NeedleFoundation

protocol DomainComponentProtocol {
    var rickAndMortyInteractor: RickAndMortyInteractor { get }
}

protocol DomainComponentDependency : Dependency {
    var rickAndMortyRepository: RickAndMortyRepository { get }
}

final class DomainComponent : Component<DomainComponentDependency>, DomainComponentProtocol {
    public var rickAndMortyInteractor: RickAndMortyInteractor {
        shared {
            RickAndMortyInteractor(
                repository: dependency.rickAndMortyRepository
            )
        }
    }
    
    var uiComponent: UiComponent {
        UiComponent(parent: self)
    }
}
