//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Ali Mert Kaya on 15.08.2023.
//

import Foundation

class CryptoListViewModel : ObservableObject {
    
    // Published -> yayın yaparak değişikleri gözlemletir
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = Webservice()
    
    func downloadCryptosAsync(url : URL) async {
        do {
            let cryptos = try await webservice.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                // map -> bir modeli diğer modele çevirir
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        } catch {
            print(error)
        }
    }
    
    /*
    func downloadCryptos(url : URL) {
        
        webservice.downloadCurrencies(url: url) { result in
            
            switch result {
                
                case .failure(let error):
                    print(error)
                
                case .success(let cryptos):
                    DispatchQueue.main.async {
                        // map -> bir modeli diğer modele çevirir
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    }
            }
        }
    }
     */
}

struct CryptoViewModel {
    
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    
    var currency : String? {
        crypto.currency
    }
    
    var price : String? {
        crypto.price
    }
}
