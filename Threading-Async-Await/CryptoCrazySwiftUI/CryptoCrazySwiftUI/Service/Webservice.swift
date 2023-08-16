//
//  Webservice.swift
//  CryptoCrazySwiftUI
//
//  Created by Ali Mert Kaya on 15.08.2023.
//

import Foundation

struct Webservice {
    
    func downloadCurrenciesAsync(url : URL) async throws -> [CryptoCurrency] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currencies ?? []
    }
    
    /*
    func downloadCurrencies(url : URL, completion : @escaping (Result<[CryptoCurrency],DownloaderError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
        }.resume()
     }
     */
}

enum DownloaderError : Error {
    case badUrl
    case noData
    case dataParseError
}
