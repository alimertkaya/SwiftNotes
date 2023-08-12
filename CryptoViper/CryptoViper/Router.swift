//
//  Router.swift
//  CryptoViper
//
//  Created by Ali Mert Kaya on 12.08.2023.
//

import Foundation

// Class, protocol
// EntryPoint

protocol AnyRouter {
    // static yaparak diğer sınıflardan erişmeyi sağlıyoruz
    static func startExecution() -> AnyRouter
    
}

class CryptoRouter : AnyRouter {
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        return router
    }
}
