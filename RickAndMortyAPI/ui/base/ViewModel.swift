//
//  ViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

@Observable
class ViewModel<ViewStateType> where ViewStateType : ViewState {
    
    init(viewState: ViewStateType) {
        self.viewState = viewState
    }
    
    private(set) var viewState: ViewStateType
    
    func doTask<D>(
        _ body: @escaping () async -> Result<D>?,
        onResult callback: @escaping (D) -> Void
    ) {
        showProgressView(true)
        Task {
            if let result = await body() {
                switch result {
                case .Success(let data): accessResult(data, onResult: callback)
                case .Failure(let data, let error): accessResult(data, error: error, onResult: callback)
                }
            }
        }
    }
    
    private func accessResult<D>(
        _ result: D?,
        error: FailureError? = nil,
        onResult callback: @escaping (D) -> Void
    ) {
        DispatchQueue.main.async { [weak self] in
            self?.mutate { state in
                state.updateErrorMessage(failure: error)
                state.showProgressView(false)
            }
            if let resultData = result {
                callback(resultData)
            }
        }
    }
    
    private func showProgressView(_ isShow: Bool) {
        viewState.showProgressView(isShow)
    }
    
    func mutate(by mutation: (inout ViewStateType) -> Void) {
        viewState.mutate(by: mutation)
    }
    
    func clearErrorMessage() {
        viewState.clearErrorMessage()
    }
}
