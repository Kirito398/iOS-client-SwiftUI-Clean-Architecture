//
//  DataComponent.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 11.10.2024.
//

import Foundation
import NeedleFoundation

protocol DataComponentProtocol {
    var rickAndMortyRepository: RickAndMortyRepository { get }
}

final class DataComponent : Component<EmptyDependency>, DataComponentProtocol {
    public var rickAndMortyRepository: RickAndMortyRepository {
        RickAndMortyRepository(
            api: rickAndMortyApi,
            cache: rickAndMortyCache
        )
    }
    
    private var rickAndMortyCache: RickAndMortyCache {
        RickAndMortyCache(cache: realmService)
    }
    
    private var realmService: RealmService {
        shared {
            RealmService()
        }
    }
    
    private var rickAndMortyApi: RickAndMortyApi {
        RickAndMortyApi(
            apiClient: rickAndMortyClient
        )
    }
    
    private var rickAndMortyClient: HttpClient {
        HttpClient(
            baseUrl: "https://rickandmortyapi.com/api/"
        )
    }
    
    var domainComponent: DomainComponent {
        DomainComponent(parent: self)
    }
}
