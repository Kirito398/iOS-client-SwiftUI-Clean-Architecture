//
//  CharacterAvatar.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 17.10.2024.
//

import SwiftUI

struct CharacterAvatar: View {
    let characterAvatarURL: String
    
    var body: some View {
        Rectangle()
            .fill(Color.customGray)
            .overlay {
                AsyncImage(url: URL(string: characterAvatarURL)
                ) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.clear
                }
            }
            .clipped()
    }
}

#Preview {
    CharacterAvatar(characterAvatarURL: CharacterDetailUI.sample.image)
}
