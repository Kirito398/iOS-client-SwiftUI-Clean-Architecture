//
//  RootComponent.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation
import NeedleFoundation

final class RootComponent : BootstrapComponent {
    
    private var _dataComponent: DataComponent {
        DataComponent(parent: self)
    }
    
    var uiComponent: UiComponentProtocol {
        _dataComponent.domainComponent.uiComponent
    }
    
    var domainComponent: DomainComponentProtocol {
        _dataComponent.domainComponent
    }
    
    var dataComponent: DataComponentProtocol {
        _dataComponent.self
    }
}
