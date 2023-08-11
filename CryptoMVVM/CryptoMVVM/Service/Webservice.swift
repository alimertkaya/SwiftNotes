//
//  Webservice.swift
//  CryptoMVVM
//
//  Created by Ali Mert Kaya on 11.08.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class Webservice {
    
    // @escaping -> fonksiyon istek atsın, cevap geldikten sonra işleme devam etsin
    // Result -> success or failure ikisinden birini simgeler. Result<success olunca, failure olunca> ne dönsün
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto],CryptoError>) -> () ) {
        // completionhandler kısmı cevap geldikten sonra çalışır
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            }
            else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                // cryptoList optional-(?) değilse
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }
                else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
