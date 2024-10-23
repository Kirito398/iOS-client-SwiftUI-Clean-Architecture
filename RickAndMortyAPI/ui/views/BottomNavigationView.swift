//
//  BottomNavigationView.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 22.10.2024.
//

import SwiftUI

protocol BottomNavigationMenuItem : CaseIterable {
    associatedtype Label : View
    
    var label: Label { get }
    var title: String? { get }
}

struct BottomNavigationView<Menu : BottomNavigationMenuItem, Content : View>: View {
    let menuList: [Menu]
    let labelForegroundColor: Color = Color.orange
    let labelSelectionForegroundColor: Color = Color.customGray
    let labelSelectionBackgroundColor: Color = Color.orange
    let bottomMenuBackgroundColor: Color = Color.customGray
    
    var content: (Menu) -> Content
    
    @State 
    private var selectedItemIndex: Int = 0
    
    @Namespace
    private var selectorAnimationNamespace
    private var selectorAnimationId = "Selector"
    
    init(
        menuList: [Menu],
        @ViewBuilder content: @escaping (Menu) -> Content
    ) {
        self.content = content
        self.menuList = menuList
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            tabContent
            bottomMenu
        }
    }
    
    private var tabContent: some View {
        TabView(selection: $selectedItemIndex) {
            ForEach(Array(menuList.enumerated()), id: \.offset) { index, menu in
                content(menu)
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    private var bottomMenu: some View {
        HStack {
            ForEach(Array(menuList.enumerated()), id: \.offset) { index, menu in
                let isSelected = selectedItemIndex == index
                
                Button {
                    withAnimation(.snappy) {
                        selectedItemIndex = index
                    }
                } label: {
                    ZStack {
                        let base = menu.label
                            .foregroundColor(isSelected ? labelSelectionForegroundColor : labelForegroundColor)
                            
                        
                        if isSelected {
                            VStack(spacing: .zero) {
                                base
                                if let title = menu.title {
                                    Text(title)
                                        .foregroundColor(labelSelectionForegroundColor)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(Dimensions.defaultPadding)
                            .background(labelSelectionBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
                            .matchedGeometryEffect(id: selectorAnimationId, in: selectorAnimationNamespace)
                        } else {
                            base.padding(Dimensions.defaultPadding)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(Dimensions.defaultPadding)
        .background(bottomMenuBackgroundColor)
    }
}
