//
//  RickAndMortyAPIApp.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 30.09.2024.
//

import SwiftUI

@main
struct RickAndMortyAPIApp: App {
    @StateObject var characterListViewModel = CharacterListViewModel(
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
            CharacterListView(viewModel: characterListViewModel)
        }
    }
}
