//
//  ErrorAlert.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import SwiftUI
import domain

struct FailureAlert<A : View>: ViewModifier {
    @State var showErrorAlert: Bool = false
    @State var showErrorMessage: Bool = false
    
    var failure: FailureError?
    @ViewBuilder var actions: (FailureError) -> A
    
    func body(content: Content) -> some View {
        VStack {
            if showErrorMessage, let failure = failure {
                ErrorMessageView(
                    title: failure.title,
                    message: failure.message
                )
            }
            
            content
                .onChange(of: failure) { _, newValue in
                    if let failure = newValue {
                        showErrorMessage = !failure.isCritical
                        showErrorAlert = failure.isCritical
                    } else {
                        showErrorAlert = false
                        showErrorMessage = false
                    }
                }
                .alert(
                    failure?.title ?? "Alert",
                    isPresented: $showErrorAlert,
                    presenting: failure,
                    actions: actions,
                    message: { failure in
                        Text(failure.message)
                    }
                )
        }
    }
}

struct ErrorMessageView : View {
    let title: String
    var message: String = ""
    
    @State
    private var showMessage: Bool = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            if showMessage && !message.isEmpty {
                Text(message)
                    .font(.caption)
            }
        }
        .onTapGesture {
            withAnimation {
                showMessage.toggle()
            }
        }
        .frame(
            maxWidth: .infinity
        )
        .padding(Dimensions.defaultPadding)
        .background(.red)
        .padding(.horizontal, -Dimensions.defaultPadding)
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
