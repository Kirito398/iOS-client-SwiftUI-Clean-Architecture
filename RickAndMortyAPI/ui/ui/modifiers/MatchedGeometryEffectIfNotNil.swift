//
//  MatchedGeometryEffectIfNotNil.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 16.10.2024.
//

import SwiftUI

struct MatchedGeometryEffectIfNotNil<ID : Hashable>: ViewModifier {
    
    var id: ID
    var namespace: Namespace.ID?
    
    func body(content: Content) -> some View {
        if let namespace = namespace {
            content
                .matchedGeometryEffect(id: id, in: namespace)
        } else {
            content
        }
    }
}

extension View {
    func matchedGeometryEffectIfNotNil<ID : Hashable>(id: ID, namespace: Namespace.ID?) -> some View {
        self.modifier(MatchedGeometryEffectIfNotNil(id: id, namespace: namespace))
    }
}
