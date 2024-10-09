//
//  RickAndMortyAPIApp.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 30.09.2024.
//

import SwiftUI

@main
struct RickAndMortyAPIApp: App {
    @ObservedObject var router = Router()
    
    @State var characterListViewModel = CharacterListViewModel(
        interactor: RickAndMortyInteractor(
            repository: RickAndMortyRepository(
                rickAndMortyApi: RickAndMortyApi(
                    apiClient: HttpClient(
                        baseUrl: "https://rickandmortyapi.com/api/"
                    )
                )
            )
        )
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                CharacterListScreen(viewModel: characterListViewModel)
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .CharacterDetail(let id): CharacterDetailScreen(characterId: id)
                        }
                    }
            }
        }
        .environmentObject(router)
    }
}
