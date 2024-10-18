//
//  CharacterInfo.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 03.10.2024.
//

import SwiftUI

struct CharacterInfoItemView: View {
    
    private var character: CharacterDetailUI
    private var geometryEffectNamespace: Namespace.ID?
    
    init(
        character: CharacterDetailUI,
        geometryEffectNamespace: Namespace.ID? = nil
    ) {
        self.character = character
        self.geometryEffectNamespace = geometryEffectNamespace
    }
    
    var body: some View {
        HStack(alignment: .top) {
            characterAvatar
            characterInfo
            Spacer()
        }
        .background(Color.customGray)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
        .matchedGeometryEffectIfNotNil(
            id: character.geometryMatchedIds.detailBlock,
            namespace: geometryEffectNamespace
        )
        .frame(maxWidth: .infinity)
    }
    
    private var characterInfo: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(character.name)
                .font(.title3)
                .fontWeight(.bold)
                .matchedGeometryEffectIfNotNil(
                    id: character.geometryMatchedIds.name,
                    namespace: geometryEffectNamespace
                )
            
            HStack {
                Circle()
                    .fill(character.status.color)
                    .frame(
                        maxWidth: Dimensions.defaultCircusMarkSize,
                        maxHeight: Dimensions.defaultCircusMarkSize
                    )
                    
                Text("\(character.status.toString()) - \(character.species)")
                    .font(.subheadline)
            }
            .padding(.bottom, Dimensions.defaultPading)
            .matchedGeometryEffectIfNotNil(
                id: character.geometryMatchedIds.status,
                namespace: geometryEffectNamespace
            )
            
            
            Text("Last known location")
                .font(.caption)
            Text(character.location.name)
                .font(.caption2)
                .padding(.bottom, Dimensions.defaultPading)
            
            Text("First seen in")
                .font(.caption)
            Text(character.origin.name)
                .font(.caption2)
        }
        .foregroundColor(.white)
        .padding(Dimensions.defaultPading)
        .lineLimit(1)
    }
    
    private var characterAvatar: some View {
        CharacterAvatarView(characterAvatar: character.avatar)
            .matchedGeometryEffectIfNotNil(
                id: character.geometryMatchedIds.avatar,
                namespace: geometryEffectNamespace
            )
            .frame(width: 130, height: 130)
    }
}

#Preview {
    CharacterInfoItemView(character: CharacterDetailUI.sample)
        .previewLayout(.fixed(width: 400, height: 60))
}

extension View {
    
}
