//
//  TitledView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 18.10.2024.
//

import SwiftUI

struct TitledView: ViewModifier {
    
    var title: String
    var font: Font
    var fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(font)
                .fontWeight(fontWeight)
            Spacer()
            content
        }
    }
}

extension View {
    func titled(_ title: String, font: Font = .title3, fontWeight: Font.Weight = .bold) -> some View {
        self.modifier(TitledView(title: title, font: font, fontWeight: fontWeight))
    }
}
 
