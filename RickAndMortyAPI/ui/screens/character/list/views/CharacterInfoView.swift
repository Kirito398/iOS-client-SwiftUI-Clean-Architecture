//
//  CharacterInfo.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 03.10.2024.
//

import SwiftUI

struct CharacterInfoView: View {
    
    private var character: CharacterDetailUI
    private var avatarNamespace: Namespace.ID?
    
    init(character: CharacterDetailUI, avatarNamespace: Namespace.ID? = nil) {
        self.character = character
        self.avatarNamespace = avatarNamespace
    }
    
    var body: some View {
        HStack(alignment: .top) {
            characterAvatar
            characterInfo
            Spacer()
        }
        .background(Color.customGray)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
    }
    
    private var characterInfo: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(character.name)
                .matchedGeometryEffectIfNotNil(
                    id: "name_\(character.id)",
                    namespace: avatarNamespace
                )
                .font(.title3)
                .fontWeight(.bold)
            
            HStack {
                Circle()
                    .fill(character.status.color)
                    .frame(maxWidth: 10, maxHeight: 10)
                    
                Text("\(character.status.toString()) - \(character.species)")
                    .font(.subheadline)
            }
            .padding(.bottom, Dimensions.defaultPading)
            
            
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
        ZStack {
            AsyncImage(url: URL(
                string: character.image)
            ) { phase in
                if let image: Image = phase.image {
                    image
                        .resizable(resizingMode: .stretch)
//                        .frame(
//                            minWidth: 130, maxWidth: 160,
//                            minHeight: 130, maxHeight: 160
//                        )
                        //.aspectRatio(contentMode: .fit)
                }
            }
        }
        .matchedGeometryEffectIfNotNil(
            id: character.id,
            namespace: avatarNamespace
        )
        .transition(.asymmetric(insertion: .identity, removal: .identity))
        .frame(width: 130, height: 130)
    }
}

#Preview {
    CharacterInfoView(character: CharacterDetailUI.sample)
        .previewLayout(.fixed(width: 400, height: 60))
}

extension View {
    
}
