//
//  RickAndMortyAPIApp.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 30.09.2024.
//

import SwiftUI

@main
struct RickAndMortyAPIApp: App {
    private let rickAndMortyInteractor = RickAndMortyInteractor(
        repository: RickAndMortyRepository(
            rickAndMortyApi: RickAndMortyApi(
                apiClient: HttpClient(
                    baseUrl: "https://rickandmortyapi.com/api/"
                )
            )
        )
    )
    
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                CharacterListScreen(viewModel: CharacterListViewModel(interactor: rickAndMortyInteractor))
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .CharacterDetail(let id): 
                            CharacterDetailScreen(
                                viewModel: CharacterDetailViewModel(
                                    interactor: rickAndMortyInteractor,
                                    characterId: id
                                )
                            )
                        }
                    }
            }
        }
        .environmentObject(router)
    }
}
