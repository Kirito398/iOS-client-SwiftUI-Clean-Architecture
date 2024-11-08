//
//  LoggerExtension.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 07.10.2024.
//

import os
import Foundation

extension String {
    public func debugLog() {
        Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Main Debug").debug("\(self)")
    }
    
    public func errorLog() {
        Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Main Error").error("\(self)")
    }
}
