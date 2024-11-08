//
//  TestScreen.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 15.10.2024.
//

import SwiftUI

struct TestScreen: View {
    
    @State
    private var isDetail: Bool = false
    
    @Namespace
    private var namespace
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if isDetail {
                ItemDetail()
                    .matchedGeometryEffect(id: 0, in: namespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        withAnimation {
                            isDetail.toggle()
                        }
                    }
            } else {
                HStack {
                    ForEach(0..<3) { id in
                        Item()
                            .matchedGeometryEffect(id: 0, in: namespace)
                            .transition(.asymmetric(insertion: .identity, removal: .identity))
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                withAnimation {
                                    isDetail.toggle()
                                }
                            }
                    }
                }
            }
        }
    }
}

struct Item : View {
    var body: some View {
        ZStack {
            item
        }
    }
    
    private var item: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.orange)
    }
}

struct ItemDetail : View {
    var body: some View {
        ZStack {
            item
        }
        //.frame(width: 300, height: 300)
    }
    
    private var item: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.orange)
    }
}

#Preview {
    TestScreen()
}
