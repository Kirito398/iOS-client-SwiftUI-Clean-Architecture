//
//  Result.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 28.10.2024.
//

import Foundation

enum Result<ResultType> {
    case Success(data: ResultType)
    case Failure(data: ResultType? = nil, error: FailureError)
}
