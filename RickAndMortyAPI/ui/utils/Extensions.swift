//
//  Extensions.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 02.10.2024.
//

import Foundation

extension FailureError {
    
    func getTitle() -> String {
        switch self {
        case .badURL:
            "Bad URL"
        case .unknown(error: let error):
            "Unknown Error"
        }
    }
    
    func getMessage() -> String {
        switch self {
        case .badURL:
            "Unknown URL"
        case .unknown(error: let error):
            error
        }
    }
    
}
