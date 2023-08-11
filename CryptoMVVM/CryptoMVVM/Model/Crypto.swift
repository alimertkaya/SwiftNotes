//
//  Crypto.swift
//  CryptoMVVM
//
//  Created by Ali Mert Kaya on 11.08.2023.
//

import Foundation

// Decodable -> veri çekerken düzgün bir formatte ise otomatik olarak decode edebilir
struct Crypto : Decodable {
        let currency : String
        let price : String
}
