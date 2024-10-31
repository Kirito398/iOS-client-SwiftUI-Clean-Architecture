//
//  PagingScrollView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 07.10.2024.
//

import SwiftUI

struct PagingScrollView<Item : Identifiable, ItemView : View> : View {
    private var isRefreshing: Bool = false
    private var hasNextPage: Bool = false
    private var onRefresh: (() -> Void)?
    
    private var items: [Item]
    private var createItemView: ((Item) -> ItemView)
    private var loadNewPage: (() -> Void)?
    
    @State
    private var isBottomProgressViewShowed: Bool = false
    
    init(
        isRefreshing: Bool = false,
        hasNextPage: Bool = false,
        items: [Item],
        createItemView: @escaping (Item) -> ItemView
    ) {
        self.isRefreshing = isRefreshing
        self.hasNextPage = hasNextPage
        self.items = items
        self.createItemView = createItemView
    }
    
    var body: some View {
        RefreshableScrollView(
            isRefreshing: isRefreshing && !isBottomProgressViewShowed,
            progressView: loadingProgressView
        ) {
            content
        }
        .refreshable {
            onRefresh?()
        }
    }
    
    private var content: some View {
        LazyVStack {
            ForEach(items) { item in
                createItemView(item)
            }
            
            if !items.isEmpty && hasNextPage {
                loadingProgressView
                    .onAppear() {
                        isBottomProgressViewShowed = true
                        loadNewPage?()
                    }
                    .onDisappear() {
                        isBottomProgressViewShowed = false
                    }
            }
        }
    }
    
    private var loadingProgressView: some View {
        ProgressView()
            .tint(Color.lightOrange)
            .padding()
    }
}

extension PagingScrollView {
    func onNewPage(loader: @escaping () -> Void) -> Self {
        var view = self
        view.loadNewPage = loader
        return view
    }
    
    func refreshable(_ onRefresh: @escaping () -> Void) -> Self {
        var view = self
        view.onRefresh = onRefresh
        return view
    }
}

//#Preview {
//    PagingScrollView()
//}
