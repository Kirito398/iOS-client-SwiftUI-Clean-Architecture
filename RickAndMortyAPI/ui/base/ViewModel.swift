//
//  ViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

protocol ViewModel : ObservableObject {
    var errorMessage: FailureError? { get set }
    
    func doTask<D>(_ body: @escaping () async throws -> D, callback: @escaping (D) -> Void)
}

extension ViewModel {
    
    func clearErrorMessage() {
        errorMessage = nil
    }
    
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
                DispatchQueue.main.async {
                    self.errorMessage = failure
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = FailureError.unknown(error: error.localizedDescription)
                }
            }
        }
    }
}
