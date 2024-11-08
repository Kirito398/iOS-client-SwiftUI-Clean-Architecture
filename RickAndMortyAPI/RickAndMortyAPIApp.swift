//
//  RickAndMortyAPIApp.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 30.09.2024.
//

import SwiftUI
import ui

@main
struct RickAndMortyAPIApp: App {
    //@ObservedObject var router: Router
    private var rootComponent: RootComponent
    
    init() {
        registerProviderFactories()
        rootComponent = RootComponent()
        //router = rootComponent.uiComponent.navigationRouter
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .appTheme()
//            NavigationStack(path: $router.navPath) {
//                CharacterListScreen(viewModel: rootComponent.uiComponent.characterListViewModel)
//                    .navigationDestination(for: Destination.self) { destination in
//                        switch destination {
//                        case .CharacterDetail(let id): 
//                            CharacterDetailScreen(
//                                viewModel: CharacterDetailViewModel(
//                                    interactor: rootComponent.domainComponent.rickAndMortyInteractor,
//                                    characterId: id
//                                )
//                            )
//                        }
//                    }
//            }
        }
        //.environmentObject(router)
    }
}
