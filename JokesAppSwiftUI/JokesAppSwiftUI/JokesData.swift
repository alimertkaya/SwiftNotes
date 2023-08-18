//
//  JokesData.swift
//  JokesAppSwiftUI
//
//  Created by Ali Mert Kaya on 18.08.2023.
//

import Foundation

struct JokesData: Identifiable, Codable {
    let id = UUID()
    let type: String
    let value: [Value]
}

struct Value: Identifiable, Codable {
    let id: Int
    let joke: String
    let categories: [String]
}
