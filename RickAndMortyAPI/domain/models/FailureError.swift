//
//  Error.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

enum FailureError : Error, Equatable {
    case badURL
    case unknown(error: String)
}
