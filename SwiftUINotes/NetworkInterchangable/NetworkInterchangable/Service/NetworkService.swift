//
//  NetworkService.swift
//  NetworkInterchangable
//
//  Created by Ali Mert Kaya on 11.09.2023.
//

import Foundation

protocol NetworkService {
    func download(_ resource : String) async throws -> [User]
    var type : String { get }
}
