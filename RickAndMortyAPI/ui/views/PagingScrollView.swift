//
//  PagingScrollView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 07.10.2024.
//

import SwiftUI

struct PagingScrollView<Item : Identifiable, ItemView : View>: View {
    var items: [Item]
    var createItemView: ((Item) -> ItemView)
    var loadNewPage: (() -> Void)?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items) { item in
                    createItemView(item)
                }
                
                loadingProgressView
                    .onAppear() {
                        loadNewPage?()
                    }
            }
        }
        
    }
    
    var loadingProgressView: some View {
        ProgressView()
            .tint(Color.lightGray)
            .padding()
    }
    
    
}

extension PagingScrollView {
    func onNewPage(loader: @escaping () -> Void) -> Self {
        var view = self
        view.loadNewPage = loader
        return view
    }
}

//#Preview {
//    PagingScrollView()
//}
