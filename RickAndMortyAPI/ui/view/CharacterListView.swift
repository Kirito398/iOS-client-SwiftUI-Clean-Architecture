//
//  CharacterListView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

struct CharacterListView: AppView {
    @ObservedObject internal var viewModel: CharacterListViewModel
    
    var content: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.name)
            
            Button {
                viewModel.fetchCharacterList()
            } label: {
                Text("Update")
            }
        }
        .padding()
        .onAppear() {
            viewModel.fetchCharacterList()
        }
    }
}

//#Preview {
//    CharacterListView()
//}
