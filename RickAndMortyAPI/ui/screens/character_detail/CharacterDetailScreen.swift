//
//  CharacterDetailScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 08.10.2024.
//

import SwiftUI

struct CharacterDetailScreen : View {
    var characterId: Int
    
    var body: some View {
        Text("Name: \(characterId)")
    }
}
