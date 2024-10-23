//
//  MainScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 22.10.2024.
//

import SwiftUI

struct MainScreen: View {
    private var rootComponent: RootComponent
    
    init() {
        registerProviderFactories()
        rootComponent = RootComponent()
    }
    
    var body: some View {
        BottomNavigationView(menuList: MenuItem.allCases) { item in
            ZStack {
                switch item {
                case .CharacterList: CharacterMainScreen(uiComponent: rootComponent.uiComponent)
                case .LocationList: LocationListScreen(viewModel: rootComponent.uiComponent.locationListViewModel)
                case .EpisodeList: Text("Episodes")
                }
            }
            .padding(EdgeInsets(
                top: Dimensions.defaultPadding,
                leading: Dimensions.defaultPadding,
                bottom: .zero,
                trailing: Dimensions.defaultPadding)
            )
        }
    }
}

#Preview {
    MainScreen()
        .appTheme()
}

enum MenuItem : BottomNavigationMenuItem {
    case CharacterList
    case LocationList
    case EpisodeList
    
    var label: some View {
        let view = switch self {
        case .CharacterList: Image(systemName: "person.crop.circle.dashed")
        case .LocationList: Image(systemName: "location.north.circle")
        case .EpisodeList: Image(systemName: "tv.circle")
        }
        
        return view
            .resizable()
            .frame(width: Dimensions.menuSize, height: Dimensions.menuSize)
    }
    
    var title: String? {
        switch self {
        case .CharacterList: "Characters"
        case .LocationList: "Locations"
        case .EpisodeList: "Episodes"
        }
    }
}
