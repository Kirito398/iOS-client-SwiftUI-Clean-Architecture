//
//  ErrorAlert.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI

struct FailureAlert<A : View>: ViewModifier {
    @State var showErrorMessage: Bool = false
    
    var failure: FailureError?
    @ViewBuilder var actions: (FailureError) -> A
    
    func body(content: Content) -> some View {
        content
            .onChange(of: failure) { _, newValue in
                showErrorMessage = newValue != nil
            }
            .alert(
                failure?.title ?? "Alert",
                isPresented: $showErrorMessage,
                presenting: failure,
                actions: actions,
                message: { failure in
                    Text(failure.message)
                }
            )
    }
}

extension View {
    func failureAlert<A : View>(
        of failure: FailureError?,
        @ViewBuilder actions: @escaping (FailureError) -> A
    )  -> some View {
        self.modifier(
            FailureAlert(
                failure: failure,
                actions: actions
            )
        )
    }
}
