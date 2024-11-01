//
//  RefreshableScrollView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 18.10.2024.
//

import SwiftUI

struct RefreshableScrollView<Content : View, Progress : View>: View {
    private let amountToPullBeforeRefreshing: CGFloat = 80
    private let amountToStartRefreshing: CGFloat = 50
    private let coordinateSpacename: String = "RefreshableScrollViewSpacename"
    
    var isRefreshing: Bool
    let progressView: Progress
    let content: Content
    private var onRefresh: (() -> Void)?
    
    @State
    private var isNeedRefreshing: Bool = false
    
    init(isRefreshing: Bool, progressView: Progress, @ViewBuilder content: () -> Content) {
        self.isRefreshing = isRefreshing
        self.progressView = progressView
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                if geometry.frame(in: .named(coordinateSpacename)).midY > amountToPullBeforeRefreshing {
                    Spacer()
                        .onAppear() {
                            withAnimation {
                                isNeedRefreshing = true
                            }
                        }
                } else if geometry.frame(in: .named(coordinateSpacename)).midY < amountToStartRefreshing {
                    Spacer()
                        .onAppear() {
                            if isNeedRefreshing {
                                onRefresh?()
                            }
                        }
                }
            }
            .padding(.top, -amountToStartRefreshing)
            .onChange(of: isRefreshing) { _, newValue in
                if !newValue {
                    withAnimation {
                        isNeedRefreshing = false
                    }
                }
            }
            
            if isNeedRefreshing {
                progressView
            }
            
            content
        }.coordinateSpace(name: coordinateSpacename)
    }
}

extension RefreshableScrollView {
    func refreshable(_ onRefresh: @escaping () -> Void) -> Self {
        var view = self
        view.onRefresh = onRefresh
        return view
    }
}

#Preview {
    CharacterListScreen(
        viewModel: RootComponent().uiComponent.characterListViewModel
    )
    .appTheme()
}
