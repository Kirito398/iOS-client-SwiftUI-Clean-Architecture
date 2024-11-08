//
//  ScreenState.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import Foundation
import domain

public protocol ViewState {
    var errorMessage: FailureError? { get set }
    var showProgressView: Bool { get set }
}

extension ViewState {
    mutating func updateErrorMessage(failure: FailureError?) {
        errorMessage = failure
    }
    
    mutating func clearErrorMessage() {
        errorMessage = nil
    }
    
    mutating func showProgressView(_ isShow: Bool) {
        showProgressView = isShow
    }
    
    mutating func mutate(by block: (inout Self) -> Void) {
        block(&self)
    }
}
