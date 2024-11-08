//
//  SearchBar.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.11.2024.
//

import SwiftUI
import Combine

struct SearchBar : View {
    @State
    private var inputText: String = ""
    
    @State
    private var publisher = PassthroughSubject<String, Never>()
    
    private let onSubmit: ((String) -> Void)?
    
    init(
        label: String = "",
        onSubmit: ((String) -> Void)? = nil
    ) {
        self.onSubmit = onSubmit
        self.inputText = label
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField(
                "Search",
                text: $inputText
            )
            .onChange(of: inputText, { oldValue, newValue in
                publisher.send(newValue)
            })
            .onReceive(
                publisher.debounce(
                    for: .seconds(1),
                    scheduler: DispatchQueue.main
                )
            ) { value in
                onSubmit?(value)
            }
            .onSubmit {
                onSubmit?(inputText)
            }
            
            if !inputText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        withAnimation {
                            inputText = ""
                            onSubmit?(inputText)
                        }
                    }
            }
        }
        .foregroundColor(.white)
        .padding(Dimensions.defaultPadding)
        .background(Color.lightOrange)
        .cornerRadius(Dimensions.cornerRadius)
    }
}

#Preview {
    SearchBar()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appTheme()
}
