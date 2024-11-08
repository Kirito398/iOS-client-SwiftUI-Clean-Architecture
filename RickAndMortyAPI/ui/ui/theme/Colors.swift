//
//  Colors.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 04.10.2024.
//

import SwiftUI

extension Color {
    static let darkGray = Color.fromRGB(red: 39, green: 43, blue: 51)
    static let customGray = Color.fromRGB(red: 60, green: 62, blue: 68)
    static let lightGray = Color.fromRGB(red: 158, green: 158, blue: 158)
    static let lightOrange = Color.fromRGB(red: 255, green: 152, blue: 0)
    static let red = Color.fromRGB(red: 214, green: 61, blue: 46)
    static let lightGreen = Color.fromRGB(red: 85, green: 204, blue: 68)
    
    static func fromRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 255) -> Color {
        Color(UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha / 255))
    }
}
