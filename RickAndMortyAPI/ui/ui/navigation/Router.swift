//
//  Router.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 08.10.2024.
//

import SwiftUI

public class Router : ObservableObject {
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func back() {
        navPath.removeLast()
    }
}
