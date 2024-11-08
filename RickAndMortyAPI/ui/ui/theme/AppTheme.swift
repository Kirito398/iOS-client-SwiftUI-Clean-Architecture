//
//  AppTheme.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 23.10.2024.
//

import SwiftUI

struct AppTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .background(Color.darkGray)
    }
}

extension View {
    func appTheme() -> some View {
        self.modifier(AppTheme())
    }
}
