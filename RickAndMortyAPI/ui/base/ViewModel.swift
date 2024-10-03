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
        _ body: @escaping () async throws -> D,
        callback: @escaping (D) -> Void
    ) {
        Task {
            do {
                let result = try await body()
                
                DispatchQueue.main.async {
                    callback(result)
                }
            } catch let failure as FailureError {
                DispatchQueue.main.async { [weak self] in
                    self?.updateErrorMessage(failure: failure)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.updateErrorMessage(
                        failure: FailureError.unknown(error: error.localizedDescription)
                    )
                }
            }
        }
    }
    
    func mutate(by mutation: (inout ViewStateType) -> Void) {
        viewState.mutate(by: mutation)
    }
    
    func updateErrorMessage(failure: FailureError?) {
        viewState.updateErrorMessage(failure: failure)
    }
    
    func clearErrorMessage() {
        viewState.clearErrorMessage()
    }
}
