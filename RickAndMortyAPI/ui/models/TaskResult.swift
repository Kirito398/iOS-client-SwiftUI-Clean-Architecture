//
//  TaskResult.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation

enum TaskResult<T> {
    case result(result: T)
    case failure(failure: FailureError)
}
