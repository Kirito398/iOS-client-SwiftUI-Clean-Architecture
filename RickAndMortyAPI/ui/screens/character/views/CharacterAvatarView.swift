//
//  CharacterAvatar.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 17.10.2024.
//

import SwiftUI

struct CharacterAvatarView: View {
    let characterAvatar: CharacterDetailUI.CharacterAvatar
    
    var body: some View {
        Rectangle()
            .fill(Color.customGray)
            .overlay {                
                let image = switch characterAvatar {
                case .cached(let uiImage):
                    Image(uiImage: uiImage)
                case .failed(let defaultAvatar):
                    Image(defaultAvatar)
                }
                
                image
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
    }
}

#Preview {
    CharacterAvatarView(characterAvatar: CharacterDetailUI.CharacterAvatar.sample)
}
