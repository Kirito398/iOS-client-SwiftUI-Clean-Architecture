//
//  RefreshableScrollView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 18.10.2024.
//

import SwiftUI

struct RefreshableScrollView<Content : View, Progress : View>: View {
    private let amountToPullBeforeRefreshing: CGFloat = 180
    
    var isRefreshing: Bool
    let progressView: Progress
    let content: Content
    private var onRefresh: (() -> Void)?
    
    init(isRefreshing: Bool, progressView: Progress, @ViewBuilder content: () -> Content) {
        self.isRefreshing = isRefreshing
        self.progressView = progressView
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            if isRefreshing {
                progressView
            }
            
            content
                .background {
                    GeometryReader { geometry in
                        let currentScrollPosition = -geometry.frame(in: .global).origin.y
                        
                        if currentScrollPosition < -amountToPullBeforeRefreshing && !isRefreshing {
                            Color.clear.preference(
                                key: RefreshViewOffsetKey.self,
                                value: currentScrollPosition
                            )
                        }
                    }
                }
        }.onPreferenceChange(RefreshViewOffsetKey.self) { scrollPosition in
            if scrollPosition < -amountToPullBeforeRefreshing && !isRefreshing {
                onRefresh?()
            }
        }
    }
}

extension RefreshableScrollView {
    func refreshable(_ onRefresh: @escaping () -> Void) -> Self {
        var view = self
        view.onRefresh = onRefresh
        return view
    }
}

struct RefreshViewOffsetKey : PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
